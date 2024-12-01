class_name Interactable
extends Area2D

signal activated
signal deactivated

#interactable is used to detect the presecence of a body in its collision shape and emit the appropriate signal
func _on_body_entered(body: Node2D) -> void:
	activated.emit()
#emits the activate signal to when colliding with a body

func _on_body_exited(body: Node2D) -> void:
	deactivated.emit()
#emits the deactivate signal to when colliding with a body
