class_name FieldCursor
extends Node

@export var grass_layer: TileMapLayer #this holds the grass terrain
@export var field_layer: TileMapLayer #this holds the dirt terrain
@export var game_tiles: TileMapLayer #this holds the tiles with logic
@export var terrain_set: int = 0 #game tiles are on this terrain set
@export var dirt_terrain: int = 1 #dirt terrain on layer 1

const tiles = preload("res://Scenes/tiles/tile.tscn") #loads the tile scene
#we create instances of this scene later

var tile_dict = {} #tile dictionary to store where all the tiles are

var mouse_pos: Vector2
var cell_pos: Vector2i
var cell_source_id: int
var local_cell_pos: Vector2

func _ready() -> void:
	#loads the tiles and fills the dictionary when the scence loads
	for cell in game_tiles.get_used_cells(): #get_used_cells() returns an interable of all the non empty tiles and we check each of them
		if game_tiles.get_cell_source_id(cell) == 2: #the interactable tiles have the source_id of 2 so we check for those
			var tile = tiles.instantiate() #creates an instance of the tile scene
			tile_dict[cell] = tile #store the instance along with the cell coordinates
			tile.position = game_tiles.map_to_local(cell) #draws the tile at the position of the cell coordinate in the world
			#map_to_local converts cell coordinates to game coordinates
			add_child(tile) #creates the tile
		

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("tile_select"):
		get_cell_info() #obtains the cell information
		check_cell() #checks the tile dictionary to see if the tile can be interacted with based on the player

func get_cell_info() -> void: #function to obtain the 
	mouse_pos = grass_layer.get_local_mouse_position()
	cell_pos = grass_layer.local_to_map(mouse_pos) #converts mouse coordinates to cell coordinates
	cell_source_id = grass_layer.get_cell_source_id(cell_pos) 
	local_cell_pos = grass_layer.map_to_local(cell_pos) #stores cell coordinates as real coordinates( may be useful later)
	#print("id: ",cell_source_id) 

func check_cell():
	var tile = tile_dict.get(cell_pos) #looks up the tile
	if tile and tile.selectable: #checks if the tile exists and is interactable 
		till_cell() #changes the tile to dirt (may be updated later for planting and other functionality)
	
func till_cell() -> void:
	if cell_source_id != -1: #-1 is assigned to unused tiles so this checks if the tiles are used
		field_layer.set_cells_terrain_connect([cell_pos], terrain_set, dirt_terrain, true) 
		#this method is what changes the tile to dirt at the specified cell position
		
	
