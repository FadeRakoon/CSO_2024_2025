class_name MapManager
extends Node2D

@onready var player: Player = $"../Player" #this holds the player node
@onready var grass_layer: TileMapLayer = $"../BG tilemap/Grass" #this holds the grass terrain
#grass layer is also used as the reference point for all cell coords
@onready var field_layer: TileMapLayer = $"../BG tilemap/Dirt"#this holds the dirt terrain
@onready var game_tiles: TileMapLayer = $"../BG tilemap/Game Tiles" #this holds the tiles with logic
@onready var nature_tiles: TileMapLayer = $"../BG tilemap/Nature"
@export var terrain_set: int = 0 #game tiles are on this terrain set
@export var dirt_terrain: int = 1 #dirt terrain on layer 1
@export var grass_terrain: int = 0 #dirt terrain on layer 1

const tiles = preload("res://Scenes/tile.tscn") #loads the tile scene
const grow_zones = preload("res://Scenes/growingzone.tscn")
const burn_tiles = preload("res://Scenes/objects/nature/burnt_tile.tscn")
const tree_zones = preload("res://Scenes/objects/nature/tree_zone.tscn")
const pollution = preload("res://Scenes/pollution_mask.tscn")
#we create instances of this scene later

var tile_dict = {} #tile dictionary to store where all the tiles are
var grow_zones_dict = {}
var tree_zones_dict = {}
var pollution_dict = {}
#may or may not need to include a grow zone dictionary to keep track of them? we see when we see

var map_pollution : int
var pollution_modifiers : int
var mouse_pos: Vector2
var cell_pos: Vector2i
var cell_source_id: int
var local_cell_pos: Vector2
var nature_sid: int
var is_small: bool

var disasters_dict = {
	
	"Flood" : load("res://Resource Files/Disasters/Flood.tres"),
	"Acid" : load("res://Resource Files/Disasters/AcidRain.tres")
}

func _ready() -> void:
	
	map_pollution = 0
	pollution_modifiers = 0
	ActionManager.night.connect(_on_time_advanced)
	#loads the tiles and fills the dictionary when the scence loads
	for cell in grass_layer.get_used_cells(): #get_used_cells() returns an interable of all the non empty tiles and we check each of them
		local_cell_pos = grass_layer.map_to_local(cell)
		if game_tiles.get_cell_source_id(cell) == 2: #the interactable tiles have the source_id of 2 so we check for those
			var tile = tiles.instantiate() #creates an instance of the tile scene
			tile_dict[cell] = tile #store the instance along with the cell coordinates
			tile.position = local_cell_pos #draws the tile at the position of the cell coordinate in the world
			#map_to_local converts cell coordinates to game coordinates
			add_child(tile) #creates the tile
			var mask = pollution.instantiate() #creates a pollution zone
			mask.position = local_cell_pos
			pollution_dict[cell] = mask
			add_child(mask)
		if field_layer.get_cell_source_id(cell) == 3: #tests for dirt layer
			var grow_zone = grow_zones.instantiate() #creates a grow zone
			grow_zone.position = local_cell_pos #places a grow zone at the cell position of the dirt layer
			grow_zones_dict[cell] = grow_zone
			add_child(grow_zone)
	return

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("tile_select"):
		get_cell_info() #obtains the cell information
		check_cell() #checks the tile dictionary to see if the tile can be interacted with based on the player
	
func _process(delta):
	update_map_pollution()

func get_cell_info() -> void: #function to obtain the 
	mouse_pos = grass_layer.get_local_mouse_position()
	cell_pos = grass_layer.local_to_map(mouse_pos) #converts mouse coordinates to cell coordinates
	cell_source_id = grass_layer.get_cell_source_id(cell_pos) 
	local_cell_pos = grass_layer.map_to_local(cell_pos) #stores cell coordinates as real coordinates( may be useful later) #can confirm was useful later :D
	nature_sid = nature_tiles.get_cell_source_id(cell_pos)

func has_tree(cell) -> bool:
	return nature_tiles.get_cell_source_id(cell) == 6 or cell in tree_zones_dict

func check_cell():
	var tile = tile_dict.get(cell_pos) #looks up the tile
	var tree_zone = tree_zones.instantiate()
	var grow_zone = grow_zones_dict.get(cell_pos)
	var plant_growing: bool = grow_zone.plantgrowing or grow_zone.plant_grown if grow_zone else false
	if tile and tile.selected and tile.selectable and not has_tree(cell_pos) and ActionManager.has_actions():
		if player.current_tool == DataTypes.Tools.TillGrass: 
			#checks if the tile exists and is interactable 
			if not cell_pos in tree_zones_dict:
				if not plant_growing and field_layer.get_cell_source_id(cell_pos) == 3: #tests for dirt
					ActionManager.action_performed.emit()
					untill_cell(cell_pos) #removes the tile if you click it and theres already dirt there
				else:
					ActionManager.action_performed.emit()
					till_cell(cell_pos) #changes the tile to dirt (may be updated later for planting and other functionality)
			elif tree_zone in get_children():
				remove_tree(tree_zone, cell_pos)	
				
		elif player.current_tool == DataTypes.Tools.BurnWood:
			var cell: Vector2i
			if cell_pos not in field_layer.get_used_cells():  
				ActionManager.action_performed.emit()
				burn_grass(cell_pos)
			await get_tree().create_timer(0.8).timeout
			for x in range(-2, 3): #iterates from -2 to 2
				for y in  range(-2, 3):
					cell = Vector2i(x,y) + cell_pos
					if cell not in field_layer.get_used_cells() and cell in tile_dict and not (abs(x) == 2 or abs(y) == 2) and not has_tree(cell):#applies burn efect within 1 cell radius
						burn_grass(cell)
					if cell in tile_dict:
						tile_dict[cell].tile_info.pollution += Global.BURN_POLLUTION
						
		elif player.current_tool == DataTypes.Tools.PlantCrops and player.current_plant == DataTypes.Plants.Trees and not (cell_pos in tree_zones_dict or cell_pos in grow_zones_dict):
			const small_rate = 0.5
			is_small = randf() < small_rate
			if CostManager.can_afford_plant(player.current_plant, is_small):
				ActionManager.action_performed.emit()
				tree_zone.position = local_cell_pos
				add_child(tree_zone)
				tree_zone.free.connect(remove_tree.bind(tree_zone, cell_pos))
				tree_zone.burn.connect(on_tree_burn.bind(cell_pos))
				tree_zones_dict[cell_pos] = tree_zone


func on_tree_burn(tree_pos):
	var cell: Vector2i
	for x in range(-1, 2): #iterates from -2 to 2
		for y in  range(-1, 2):
			cell = Vector2i(x,y) + tree_pos
			if cell in tile_dict:
				tile_dict[cell].tile_info.pollution += Global.BURN_POLLUTION

func remove_tree(tree_zone, cell: Vector2i):
	print("Got here")
	remove_child(tree_zone)	
	tree_zones_dict.erase(cell_pos)
	tree_zone.queue_free()

func till_cell(cell: Vector2i) -> void:
	nature_tiles.set_cell(cell, -1)
	field_layer.set_cells_terrain_connect([cell], terrain_set, dirt_terrain, true) 
	#this method is what changes the tile to dirt at the specified cell position
	var grow_zone = grow_zones.instantiate() #creates a grow zone
	grow_zone.position = grass_layer.map_to_local(cell)
	grow_zones_dict[cell] = grow_zone
	add_child(grow_zone)
	
func _on_time_advanced():
	
	var possible_disasters : Array
	var growth_enabled = true
	
	for cell in grass_layer.get_used_cells():
		if field_layer.get_cell_source_id(cell) == 3 :
			grow_zones_dict[cell].plant_scene.fertility = tile_dict[cell].tile_info.fertility
			grow_zones_dict[cell].plant_scene.moisture = tile_dict[cell].tile_info.moisture
	
	for event in disasters_dict.keys():
		if map_pollution > disasters_dict[event].pollution_threshold :
			possible_disasters.append(disasters_dict[event])
	
	if not possible_disasters.is_empty(): 
		var round_disaster = possible_disasters.pick_random()
		if randi_range(0, 100) < round_disaster.dist_probability :
			match round_disaster.disaster_name:
				"Acid Rain" :
					DisasterManager.disaster_warn(DataTypes.Disaster.AcidRain)
					growth_enabled = false
				"Flood" :
					DisasterManager.disaster_warn(DataTypes.Disaster.Flood)
					for zone in grow_zones_dict:
						if randi_range(0, 100) < round_disaster.dist_probability :
							grow_zones_dict[zone].reset_plant()
	if not growth_enabled :
		for zone in grow_zones_dict:
			grow_zones_dict[zone].plant_scene.circumstance = false
	else : 
		for zone in grow_zones_dict:
			grow_zones_dict[zone].plant_scene.circumstance = true
			

func untill_cell(cell: Vector2i) -> void:
	field_layer.set_cell(cell, -1) #removes the tile
	remove_child(grow_zones_dict[cell]) #removes the growth zone
	grow_zones_dict.erase(cell) #frees space in the dictionary
		
func burn_grass(cell: Vector2i) -> void:
	var burnt_tile = burn_tiles.instantiate()
	burnt_tile.position = grass_layer.map_to_local(cell)
	add_child(burnt_tile)
	burnt_tile.burn()
	till_cell(cell)
	tile_dict[cell].tile_info.fertility += Global.BURN_FERTILITY
	
func get_map_pollution() -> int:
	return map_pollution

func set_map_pollution(poll_value) -> void:
	map_pollution = poll_value
	return

func calc_pollution() -> int :
	var cumul_pollution = 0
	for t in tile_dict.keys():
		cumul_pollution += tile_dict[t].tile_info.pollution
	return cumul_pollution

func update_map_pollution() -> int:
	var new_poll = calc_pollution() + pollution_modifiers
	map_pollution = new_poll
	#print(map_pollution)
	return map_pollution
