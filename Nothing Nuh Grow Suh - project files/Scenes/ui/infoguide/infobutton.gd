extends TextureButton

var balloon_scene = preload("res://dialogue/game_dialogue.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void: #shows dialogue box when button is pressed
	var balloon: GameDialogue = balloon_scene.instantiate()
	get_parent().add_child(balloon)
	balloon.start(load("res://dialogue/conversations/guide.dialogue"), "start")
