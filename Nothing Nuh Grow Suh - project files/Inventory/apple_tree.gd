extends Node2D

var state = "no apples" #states apple tree can be in, no apples and apples
var player_in_area = false #player not in area at the start of the game

func _ready() -> void:
	if state == "no apples": #if there are no apples at the start of the game
		$apple_growth_timer.start()

func _process(delta):
	if state == "no apples":
		$AnimatedSprite2D.play("no apples")
	if state == "apples":
		$AnimatedSprite2D.play("apples")
		if player_in_area:
			if Input.is_action_just_pressed("p"): #p on keyboard to pick the apple
				state = "no apples"
				$apple_growth_timer.start() 



func _on_pickable_area_body_entered(body: Node2D) -> void: #connected nodes to detect player entering area
	if body.has_method("player"): #checks player.gd for player function
		player_in_area = true

func _on_pickable_area_body_exited(body: Node2D) -> void: #connected nodes to detect player exiting area
	if body.has_method("player"):
		player_in_area = false

func _on_apple_growth_timer_timeout() -> void:
	if state == "no apples":
		state = "apples"
