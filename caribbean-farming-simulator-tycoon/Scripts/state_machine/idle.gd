extends NodeState
#makes this child node a node state

@export var player: Player
#for debugging to select the palyer or a test player scene if necessary
@export var animated_sprite: AnimatedSprite2D
#also for debugging

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	if player.player_direction == Vector2.UP:
		animated_sprite.play("idle_back")
	elif player.player_direction == Vector2.DOWN:
		animated_sprite.play("idle_front")
	elif player.player_direction == Vector2.LEFT:
		animated_sprite.play("idle_left")
	elif player.player_direction == Vector2.RIGHT:
		animated_sprite.play("idle_right")
	else:
		animated_sprite.play("idle_front")
	#constantly plays the idle animation and updates based on what the player direction is set to
	
func _on_next_transitions() -> void:
	GameInputEvents.movement_input()
	#sets the static variable direction to allow transitioning to the walk state
	
	if GameInputEvents.is_movement_input():
		transition.emit("walk")
	#emits walk if the player is holding a direction
	
	#emits tool action states if the player is holding a tool and is using it
	if player.current_tool == DataTypes.Tools.AxeWood and GameInputEvents.using_tool():
		transition.emit("chop")
	
	if player.current_tool == DataTypes.Tools.TillGrass and GameInputEvents.using_tool():
		transition.emit("till")
	
	if player.current_tool == DataTypes.Tools.WaterCrops and GameInputEvents.using_tool():
		transition.emit("water")
	
	#transtions to other states are controlled here
	#sends the appropriate transition signal for the transition_to function in node state machine
		
func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite.stop()
	#stops animation before transitioning to another state
