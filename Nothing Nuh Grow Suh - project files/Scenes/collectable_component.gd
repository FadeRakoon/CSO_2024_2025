class_name CollectableComponent
extends Area2D

@export var collectable_name: String #allows for collectable component to be reusable

func _on_body_entered(body: Node2D) -> void:
	print("Body entered: ", body)
	if body is Player:
		print("collected: ", collectable_name)
		get_parent().queue_free()
