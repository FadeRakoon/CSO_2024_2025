extends Area2D

var selected = false
var selectable = false

func _ready() -> void:
	visible = false
	
func _on_mouse_entered() -> void:
	if selectable:
		selected = true
	
func _on_mouse_exited() -> void:
	selected = false
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("tile_select") and selected:
		pass
		
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_aoi"):
		selectable = true
		visible = true
		
func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player_aoi"):
		selectable = true
		visible = false
