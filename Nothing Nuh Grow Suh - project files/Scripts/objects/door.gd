extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var interactable_component: Interactable = $InteractableComponent
#gets references to animated sprite, collision shape and the node for the interactable
#interactable is used here to detect the player entering the door's detection box for it to open and close

func _ready() -> void:
	interactable_component.activated.connect(on_activated)
	interactable_component.deactivated.connect(on_deactivated)
	ActionManager.time_advanced.connect(on_time_advanced)
	ActionManager.transition_complete.connect(on_transition_complete)
	collision_layer = 1
	#at the start of the scene the signals are connected to the below functions 
	#collision_layer set to 1 to block the player (player mask is on layer 1)
	
func on_activated() -> void:
	animated_sprite_2d.play("open")
	collision_layer = 2
	#this function is called when activated signal is emitted
	#collison_layer is changed to allow player to walk throught the door
	
func on_deactivated() -> void:
	animated_sprite_2d.play("close")
	collision_layer = 1
	#this function is called when deactivated signal is emitted
	#collison_layer is changed to block player again

func on_time_advanced():
	on_deactivated()
	
func on_transition_complete():
	on_activated()
