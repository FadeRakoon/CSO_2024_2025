class_name TileManager
extends Node2D

@onready var tile:Tile = get_parent() #gets a reference to the tile parent
@onready var map_manager:MapManager = tile.get_parent() #gets a reference to the map manager node 
@onready var cell_coords: Vector2i
#tile state and info variables
var plantable:bool
var pollution = 0
var fertility = 0
var moisture = 0

func _ready() -> void:
	#gets the cell coords of the tile on the game map7
	cell_coords = map_manager.game_tiles.local_to_map(tile.position) 
	
func _process(delta: float) -> void:
	#every frame the tile checks if it is plantable i.e. is on a dirt tile
	plantable =  map_manager.field_layer.get_cell_source_id(cell_coords) == 3 #3 is the id of the dirt tiles on the game tileset
	#below is for debug 
	#right now it tests to see if changing variable values are stored properly for each tile
	#checking if clicking a dirt tile will correctly update and store pollution
	if plantable: 
		if tile.selected and Input.is_action_just_pressed("tile_select"):
			print("cell coords: ",cell_coords, " - pollution: ", pollution)
			pollution += 1
	
