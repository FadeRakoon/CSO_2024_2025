extends CanvasModulate

@export var transition_gradient: GradientTexture1D

@export var fade_time: float = 1.0  # Time for the fade effect

func _ready() -> void:
	ActionManager.time_advanced.connect(transition)
	
func transition():
	var tween  = create_tween()
	GameInputEvents.can_move = false
	tween.tween_method(transition_sample, PI, 0.0, fade_time/2)
	tween.tween_method(transition_sample, 0.0, PI, fade_time/2)
	tween.finished.connect(on_transition_done)
	
func transition_sample(time: float):
	var sample_value = 0.5 * (sin(time - PI * 0.5) + 1.0)
	color = transition_gradient.gradient.sample(sample_value)
	if time == 0.0:
		ActionManager.night.emit()

func on_transition_done():
	ActionManager.transition_complete.emit()
	GameInputEvents.can_move = true
