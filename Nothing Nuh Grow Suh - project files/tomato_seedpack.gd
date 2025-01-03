extends StaticBody2D

var selected = false
var seed_type = 2 #2 represents tomato seed type

func _ready(): #takes the animated sprite which is named default
	$AnimatedSprite2D.play("default")
	
#this function checks the seed type based on the click
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		Global.plantselected = seed_type
		selected = true

#allows you to drag seed bag around
func _physics_process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		
#allows you to let seed bag go (so it doesn't drag around infinitely)
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			
		
