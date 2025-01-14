extends Node


var game_menu_screen = preload("res://Scenes/ui/game_menu_screen.tscn")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("game_menu"):
		show_game_menu_screen()

func show_game_menu_screen() ->void:
	var game_menu_screen_instance = game_menu_screen.instantiate()
	get_tree().root.add_child(game_menu_screen_instance)

var Map:String

func start_game() -> void:
	var Selected_level: String = Map #map chosen from map selection
	SceneManager.load_main_scene_container()
	SceneManager.load_mapSelect_scene_container()
	
	SceneManager.load_level(Selected_level)
	
	
func exit_game() -> void:
	get_tree().quit()
