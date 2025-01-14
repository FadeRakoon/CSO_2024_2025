extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_game_button_pressed() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	GameManager.exit_game()


func _on_jamaica_map_pressed() -> void:
	GameManager.Map = "Jamaica" 

func _on_barbados_map_pressed() -> void:
	GameManager.Map = "Barbados"

func _on_trinidad_map_pressed() -> void:
	GameManager.Map = "Trinidad"
