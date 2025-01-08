extends Node

@export var action_count : int
var current_day : int

signal time_advanced


func _ready():
	action_count = 10
	current_day = 1
	
	
func has_actions() -> bool : 
	return action_count > 0
	
func perform_action():
	action_count = clamp( action_count - 1, 0, action_count)
	if action_count <= 0 :
		time_advanced.emit()

func on_time_advanced():
	current_day += 1
	
func set_day(day : int):
	current_day = day

func get_day():
	return current_day
