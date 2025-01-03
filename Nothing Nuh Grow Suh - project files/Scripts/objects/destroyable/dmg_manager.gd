class_name Dmg_Manager
extends Node2D

@export var max_dmg = 1
@export var current_dmg = 0
#initialises the current damage and max allowable damage of its parent object
#edited in the inspector based on each object, but these are default values

signal max_dmg_reached
#initialises max damage signal

func apply_dmg(dmg: int) -> void:
	current_dmg = clamp(current_dmg + dmg, 0, max_dmg) #updates damage keeping it between 0 and max
	
	if current_dmg == max_dmg:
		max_dmg_reached.emit()
		#emits the signal when the max damage has been reached
