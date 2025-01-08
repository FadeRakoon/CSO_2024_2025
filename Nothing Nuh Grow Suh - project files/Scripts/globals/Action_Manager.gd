# This autoload manages the passage of time and actions
# As of right now, time is advanced automatically
extends Node

const MAXACTIONS = 4

@export var action_count : int
var current_day : int

#These signals can be called by other nodes by virtue of this being an autoload
signal time_advanced
signal action_performed

func _ready():
	reset_action_count()
	current_day = 1
	action_performed.connect(perform_action)
	time_advanced.connect(on_time_advanced)
	
func has_actions() -> bool : 
	return action_count > 0
	
func perform_action():
	#clamp sets a maximum and minimum value for the action_count 
	#this is a failsafe in case multiple actions happen at once before the next day transitions
	action_count = clamp( action_count - 1, 0, action_count)
	if action_count <= 0 :
		#Advance time after action counts fall to zero
		time_advanced.emit()
		reset_action_count()
	

#Function that executes after time is advanced
func on_time_advanced():
	set_day(current_day+1)

#setter-getter functions are good because as your program scales, updating require multiple actions
func set_day(day : int):
	current_day = day

func get_day():
	return current_day

func reset_action_count():
	action_count = MAXACTIONS
