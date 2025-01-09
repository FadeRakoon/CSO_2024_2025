extends Node2D

var burning: bool = false
@onready var value : float = 0.25  # Initial value
var end_value: float = 0.0
var decrease_rate : float = 0.0005  # How much the value decreases per second
@onready var grass: Sprite2D = $grass
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready() -> void:
	grass.material = grass.material.duplicate()

func _process(delta: float) -> void:
	if burning:
		if value > end_value:
			value -= decrease_rate   # Decrease value over time
		if value < end_value:  # Make sure the value doesn't go below zero
			value = end_value
			burning = false
		grass.material.set_shader_parameter("integrity", value)
		print(value)  # Print the current value to the output for testing
