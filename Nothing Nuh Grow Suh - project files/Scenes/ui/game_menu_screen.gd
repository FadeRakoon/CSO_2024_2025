extends CanvasLayer

#NOT NEEDED ANYMORE


func _on_start_game_button_pressed() -> void:
	GameManager.start_game()
	queue_free()

func _on_exit_pressed() -> void:
	GameManager.exit_game()
