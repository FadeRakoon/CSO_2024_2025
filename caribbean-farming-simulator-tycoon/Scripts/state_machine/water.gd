extends NodeState

@export var player: Player
@export var animated_sprite: AnimatedSprite2D

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if !animated_sprite.is_playing():
		transition.emit("idle")


func _on_enter() -> void:
	if player.player_direction == Vector2.UP:
		animated_sprite.play("water_back")
	elif player.player_direction == Vector2.DOWN:
		animated_sprite.play("water_front")
	elif player.player_direction == Vector2.LEFT:
		animated_sprite.play("water_left")
	elif player.player_direction == Vector2.RIGHT:
		animated_sprite.play("water_right")
	else:
		animated_sprite.play("water_right")

func _on_exit() -> void:
	animated_sprite.stop()
