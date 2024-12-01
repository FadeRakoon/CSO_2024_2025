extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var interactable_component: Interactable = $InteractableComponent

func _ready() -> void:
	interactable_component.activated.connect(on_activated)
	interactable_component.deactivated.connect(on_deactivated)
	collision_layer = 1
	
func on_activated() -> void:
	animated_sprite_2d.play("open")
	collision_layer = 2
	print("active")
	
func on_deactivated() -> void:
	animated_sprite_2d.play("close")
	collision_layer = 1
	print("inactive")
