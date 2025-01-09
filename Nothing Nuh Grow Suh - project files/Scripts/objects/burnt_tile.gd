extends Node2D

@onready var grass: Sprite2D = $grass
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready() -> void:
	grass.material = grass.material.duplicate()

func burn() ->void:
	var tween = create_tween()
	tween.tween_method(set_integrity, 0.25, 0, 2)
	
func set_integrity(val: float) -> void:
	grass.material.set_shader_parameter("integrity", val)
