extends Area2D

func _on_body_entered(body: Node2D) -> void:
	ActionManager.time_advanced.emit()
	
