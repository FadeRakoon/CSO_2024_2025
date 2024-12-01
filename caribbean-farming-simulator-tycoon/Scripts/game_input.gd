class_name GameInputEvents

static var direction: Vector2

static func movement_input() -> Vector2:
	if Input.is_action_pressed("walk_up"):
		direction = Vector2.UP
	elif Input.is_action_pressed("walk_down"):
		direction = Vector2.DOWN
	elif Input.is_action_pressed("walk_left"):
		direction = Vector2.LEFT
	elif Input.is_action_pressed("walk_right"):
		direction = Vector2.RIGHT
	else:
		direction = Vector2.ZERO
	return direction
#updates direction for the class and returns it if needed

static func is_movement_input() -> bool:
	return not (direction == Vector2.ZERO)
#returns wheter or not the user is trying to move

static func using_tool()-> bool:
	var tool_active: bool = Input.is_action_just_pressed("use")
	return tool_active
