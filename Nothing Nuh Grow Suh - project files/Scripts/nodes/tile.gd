class_name Tile
extends Area2D

var selected = false #used to determine whether or not the mouse is in the tile area
var selectable = false #used to check whether or not tile is in player's area of influence
var clicked = false
@onready var player: Player = get_node("/root/Game/Player")
@onready var tile_sprite: TileMap = $"Tile Sprite"
@onready var tile_info: TileManager = $"Tile Info"
var cell_pos: Vector2i
var active_id = 0
var clicked_id = 1
var selected_id = 2

func _ready() -> void:
	visible = false #hides the tiles by default
	cell_pos = tile_sprite.get_used_cells(0)[0]
	
func _on_mouse_entered() -> void:
	if selectable: #checks if the player can interact with the tile
		selected = true 
		#print("mouse entered")
		tile_sprite.set_cell(0, cell_pos, selected_id, Vector2i(0,0), 0)
		#var mouse_pos = tile_map.get_local_mouse_position()
		#print("Mouse entered at: ", mouse_pos)
	
func _on_mouse_exited() -> void:
	selected = false
	tile_sprite.set_cell(0, cell_pos, active_id, Vector2i(0,0), 0)
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("tile_select") and selected:
		#print("clicked")
		clicked = true
		tile_sprite.set_cell(0, cell_pos, clicked_id, Vector2i(0,0), 0)
		await get_tree().create_timer(0.2).timeout
		clicked = false
		tile_sprite.set_cell(0, cell_pos, selected_id, Vector2i(0,0), 0)
		
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_aoi"):
		selectable = true
		visible = true
#updates the appropriate states when the tile is within the player's area of influence

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player_aoi"):
		selectable = false
		visible = false
#updates the appropriate states when the tile leaves the player's area of influence

func _process(_delta: float) -> void:
	if not clicked:
		if selected:
			tile_sprite.set_cell(0, cell_pos, selected_id, Vector2i(0,0), 0)
		else:
			tile_sprite.set_cell(0, cell_pos, active_id, Vector2i(0,0), 0)
	if selected and Input.is_action_just_pressed("tile_select"):
		#watering
		if player.current_tool == DataTypes.Tools.WaterCrops:
			tile_info.water()
		if player.current_tool == DataTypes.Tools.FertilizeCrops:
			tile_info.fertilize()
		#print("cell coords: ",tile_info.cell_coords, "fertility: ",tile_info.fertility)
