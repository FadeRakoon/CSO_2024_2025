extends CanvasLayer

@export var fade_time: float = 1.0  # Time for the fade effect
@onready var player: Player = $"../Player"
var player_start_pos

func _ready() -> void:
	player_start_pos = player.global_position
	ActionManager.time_advanced.connect(reset_player)
	$ColorRect.modulate.a = 0.0
	layer = -1

func fade_to_black() -> void:
	layer  = 2
	var tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "modulate:a", 0.7, fade_time)
	await tween.finished

func fade_to_clear() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "modulate:a", 0.0, 2)
	await tween.finished
	layer  = -1

func reset_player():
	print("time advanced")
	# Fade out
	await fade_to_black()
	# Reset the player's position
	# Optionally reset player state (e.g., health, velocity, etc.)
	player.global_position = player_start_pos
	# Fade back in
	await fade_to_clear()
