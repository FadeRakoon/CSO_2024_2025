class_name NodeState
extends Node

#nodestate class used to hold state control state execution methods and transition signal
@warning_ignore("unused_signal")
signal transition 
#declares the transition signal

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	pass


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	pass
