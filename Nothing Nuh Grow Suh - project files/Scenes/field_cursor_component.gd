class_name FieldCursor
extends Node

@export var grass_layer: TileMapLayer
@export var field_layer: TileMapLayer
@export var game_tiles: TileMapLayer
@export var terrain_set: int = 0
@export var terrain: int = 1
const tiles = preload("res://Scenes/tiles/tile.tscn")

var tile_dict = {}

var mouse_pos: Vector2
var cell_pos: Vector2i
var cell_source_id: int
var local_cell_pos: Vector2
var distance: float
var selectable: bool = false

func _ready() -> void:
	for cellpos in game_tiles.get_used_cells():
		if game_tiles.get_cell_source_id(cellpos) == 2:
			var tile = tiles.instantiate()
			tile_dict[cellpos] = tile
			tile.position = game_tiles.map_to_local(cellpos)
			add_child(tile)
			#game_tiles.set_cell(cellpos, -1)
		

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("tile_select"):
		get_mouse_cell()
		check_cell()

func get_mouse_cell() -> void:
	mouse_pos = grass_layer.get_local_mouse_position()
	cell_pos = grass_layer.local_to_map(mouse_pos)
	cell_source_id = grass_layer.get_cell_source_id(cell_pos)
	local_cell_pos = grass_layer.map_to_local(cell_pos)
	print("id: ",cell_source_id)

func check_cell():
	var tile = tile_dict.get(cell_pos)
	if tile and tile.selectable:
		till_cell()
	
func till_cell() -> void:
	if cell_source_id != -1:
		field_layer.set_cells_terrain_connect([cell_pos], terrain_set, terrain, true)
		
func update_selectable():
	selectable = true
	
