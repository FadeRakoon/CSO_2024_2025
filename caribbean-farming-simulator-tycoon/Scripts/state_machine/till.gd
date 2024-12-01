extends NodeState
#makes this child node a node state

@export var player: Player
#for debugging to select the palyer or a test player scene if necessary
@export var animated_sprite: AnimatedSprite2D
#also for debugging

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if !animated_sprite.is_playing():
		transition.emit("idle")
	#transitions back to idle when the animation is complete

func _on_enter() -> void:
	if player.player_direction == Vector2.UP:
		animated_sprite.play("till_back")
	elif player.player_direction == Vector2.DOWN:
		animated_sprite.play("till_front")
	elif player.player_direction == Vector2.LEFT:
		animated_sprite.play("till_left")
	elif player.player_direction == Vector2.RIGHT:
		animated_sprite.play("till_right")
	else:
		animated_sprite.play("till_right")
	#plays the approrpiate animation based on direction
	
func _on_exit() -> void:
	animated_sprite.stop()
	#stops the animation when transitioning to another state
