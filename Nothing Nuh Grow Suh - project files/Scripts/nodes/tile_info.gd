class_name TileManager
extends Node2D

@onready var tile:Tile = get_parent() #gets a reference to the tile parent
@onready var map_manager = tile.get_parent() #gets a reference to the map manager node 
@onready var cell_coords: Vector2i
#tile state and info variables
var plantable:bool
var pollution = 0
var fertility = 25
var moisture = 25
const max_moisture = 50
const max_pollution = 50
const max_fertility = 50

func _ready() -> void:
	#gets the cell coords of the tile on the game map7
	cell_coords = map_manager.game_tiles.local_to_map(tile.position) 
	
func _process(delta: float) -> void:
	#every frame the tile checks if it is plantable i.e. is on a dirt tile
	plantable =  map_manager.field_layer.get_cell_source_id(cell_coords) == 3 #3 is the id of the dirt tiles on the game tileset

func water(amount: float = 10) -> void:
	moisture = clamp(moisture + amount, 0, max_moisture)

func fertilize(amount: float = 5) -> void:
	fertility = clamp(fertility + amount, 0, max_fertility)
	
func treat_pollution(amount: float = 5) -> void:
	pollution = clamp(pollution - amount, 0, max_pollution)
