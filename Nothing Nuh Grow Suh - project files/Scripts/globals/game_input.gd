class_name GameInputEvents

static var direction: Vector2

static func movement_input() -> Vector2:
	if Input.is_action_pressed("walk_up"):
		direction.y = -1
	elif Input.is_action_pressed("walk_down"):
		direction.y = 1
	else:
		direction.y = 0
	
	if Input.is_action_pressed("walk_left"):
		direction.x = -1
	elif Input.is_action_pressed("walk_right"):
		direction.x = 1
	else:
		direction.x = 0
	return direction
#updates direction for the class and returns it if needed

static func is_movement_input() -> bool:
	return not (direction == Vector2.ZERO)
#returns wheter or not the user is trying to move

static func using_tool()-> bool:
	var tool_active: bool = Input.is_action_just_pressed("use")
	return tool_active 
	
