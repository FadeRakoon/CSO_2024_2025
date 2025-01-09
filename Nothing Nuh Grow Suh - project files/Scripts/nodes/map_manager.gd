class_name MapManager
extends Node

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
#we create instances of this scene later

var tile_dict = {} #tile dictionary to store where all the tiles are
var grow_zones_dict = {}
#may or may not need to include a grow zone dictionary to keep track of them? we see when we see

var mouse_pos: Vector2
var cell_pos: Vector2i
var cell_source_id: int
var local_cell_pos: Vector2
var nature_sid: int

func _ready() -> void:
	#loads the tiles and fills the dictionary when the scence loads
	for cell in grass_layer.get_used_cells(): #get_used_cells() returns an interable of all the non empty tiles and we check each of them
		local_cell_pos = grass_layer.map_to_local(cell)
		if game_tiles.get_cell_source_id(cell) == 2: #the interactable tiles have the source_id of 2 so we check for those
			var tile = tiles.instantiate() #creates an instance of the tile scene
			tile_dict[cell] = tile #store the instance along with the cell coordinates
			tile.position = local_cell_pos #draws the tile at the position of the cell coordinate in the world
			#map_to_local converts cell coordinates to game coordinates
			add_child(tile) #creates the tile
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
	
func get_cell_info() -> void: #function to obtain the 
	mouse_pos = grass_layer.get_local_mouse_position()
	cell_pos = grass_layer.local_to_map(mouse_pos) #converts mouse coordinates to cell coordinates
	cell_source_id = grass_layer.get_cell_source_id(cell_pos) 
	local_cell_pos = grass_layer.map_to_local(cell_pos) #stores cell coordinates as real coordinates( may be useful later)
	nature_sid = nature_tiles.get_cell_source_id(cell_pos)

func check_cell():
	var tile = tile_dict.get(cell_pos) #looks up the tile
	var grow_zone = grow_zones_dict.get(cell_pos)
	var plant_growing: bool = grow_zone.plantgrowing or grow_zone.plant_grown if grow_zone else false
	var has_tree: bool = nature_tiles.get_cell_source_id(cell_pos) == 6
	if tile and tile.selected and tile.selectable and not has_tree:
		if player.current_tool == DataTypes.Tools.TillGrass: 
			#checks if the tile exists and is interactable 
			if not plant_growing and field_layer.get_cell_source_id(cell_pos) == 3: #tests for dirt
				untill_cell(cell_pos) #removes the tile if you click it and theres already dirt there
			else:
				till_cell(cell_pos) #changes the tile to dirt (may be updated later for planting and other functionality)
		elif player.current_tool == DataTypes.Tools.BurnWood:
			var cell: Vector2i
			burn_grass(cell_pos)
			await get_tree().create_timer(0.8).timeout
			for x in [-1,0,1]:
				for y in [-1,0,1]:
					cell = Vector2i(x,y) + cell_pos
					burn_grass(cell)
			
				
	
func till_cell(cell: Vector2i) -> void:
	nature_tiles.set_cell(cell, -1)
	field_layer.set_cells_terrain_connect([cell], terrain_set, dirt_terrain, true) 
	#this method is what changes the tile to dirt at the specified cell position
	var grow_zone = grow_zones.instantiate() #creates a grow zone
	grow_zone.position = grass_layer.map_to_local(cell)
	grow_zones_dict[cell] = grow_zone
	add_child(grow_zone)
	
func untill_cell(cell: Vector2i) -> void:
	field_layer.set_cell(cell, -1) #removes the tile
	remove_child(grow_zones_dict[cell]) #removes the growth zone
	grow_zones_dict.erase(cell) #frees space in the dictionary
		
func burn_grass(cell: Vector2i) -> void:
	if cell not in field_layer.get_used_cells():
		var burnt_tile = burn_tiles.instantiate()
		burnt_tile.position = grass_layer.map_to_local(cell)
		add_child(burnt_tile)
		burnt_tile.burn()
		till_cell(cell)
