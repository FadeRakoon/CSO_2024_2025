extends NodeState
#makes this child node a node state

@export var player: Player
#for debugging to select the palyer or a test player scene if necessary
@export var animated_sprite: AnimatedSprite2D
#also for debugging
@export var speed: int = 50
#sets walk speed

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	#updates the following every frame
	var direction = GameInputEvents.movement_input()
	#gets the player's direction 
	
	if direction == Vector2.UP:
		animated_sprite.play("walk_back")
	elif direction == Vector2.DOWN:
		animated_sprite.play("walk_front")
	elif direction == Vector2.LEFT:
		animated_sprite.play("walk_left")
	elif direction == Vector2.RIGHT:
		animated_sprite.play("walk_right")
		
	#plays the appropriate sprite based on direction
	
	if direction != Vector2.ZERO:
		player.player_direction = direction
	#updates the direction for the player parent node
	
	player.velocity = direction * speed
	player.move_and_slide()
	#moves the player 

func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("idle")
	#transitions to idle when the player isnt moving

func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite.stop()
	#stops the animation when the payer stops walking
