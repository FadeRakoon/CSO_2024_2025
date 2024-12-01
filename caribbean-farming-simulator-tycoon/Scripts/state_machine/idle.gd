extends NodeState

@export var player: Player
@export var animated_sprite: AnimatedSprite2D
var direction: Vector2

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
		

func _on_next_transitions() -> void:
	GameInputEvents.movement_input()
	
	if GameInputEvents.is_movement_input():
		transition.emit("walk")
	
	if player.current_tool == DataTypes.Tools.AxeWood and GameInputEvents.using_tool():
		transition.emit("chop")
	
	if player.current_tool == DataTypes.Tools.TillGrass and GameInputEvents.using_tool():
		transition.emit("till")
	
	if player.current_tool == DataTypes.Tools.WaterCrops and GameInputEvents.using_tool():
		transition.emit("water")
		
func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite.stop()
