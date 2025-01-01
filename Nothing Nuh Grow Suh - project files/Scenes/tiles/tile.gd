extends Area2D

var selected = false #used to determine whether or not the mouse is in the tile area
var selectable = false #used to check whether or not tile is in player's area of influence

func _ready() -> void:
	visible = false #hides the tiles by default
	
func _on_mouse_entered() -> void:
	if selectable: #checks if the player can interact with the tile
		selected = true 
	
func _on_mouse_exited() -> void:
	selected = false
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("tile_select") and selected:
		pass 
#currently we do nothing in this script when the mouse is clicked
#may be used later on to change\update tile properties 
		
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_aoi"):
		selectable = true
		visible = true
#updates the appropriate states when the tile is within the player's area of influence

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player_aoi"):
		selectable = true
		visible = false
#updates the appropriate states when the tile leaves the player's area of influence
