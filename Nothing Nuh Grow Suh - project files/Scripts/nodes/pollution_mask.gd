extends Sprite2D

var cell_pos
var tile_placed: Tile
var alpha = 0
@onready var map_manager: MapManager = get_parent()

const base_alpha = 0.3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Color(0.78, 0.2, 0.99, alpha)
	cell_pos = map_manager.grass_layer.local_to_map(position)
	tile_placed = map_manager.tile_dict.get(cell_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var max_pollution = tile_placed.tile_info.max_pollution
	alpha = float(tile_placed.tile_info.pollution)/max_pollution * base_alpha
	modulate = Color(0.78, 0.2, 0.99, alpha)
