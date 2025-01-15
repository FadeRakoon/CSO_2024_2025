extends Node

var game_menu_screen = preload("res://Scenes/ui/Map_game_menu_screen.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("game_menu"):
		show_game_menu_screen()

func show_game_menu_screen() ->void:
	var game_menu_screen_instance = game_menu_screen.instantiate()
	get_tree().root.add_child(game_menu_screen_instance)
	
var selected_map: String
signal map_selected (map: String) #declaration for signal to get what button user pressed on map selection
func Map_select (map: String) -> void:
	map_selected.emit(map)
	selected_map = map

func start_game() -> void:
	#load main scene
	SceneManager.load_main_scene_container()
	#load level
	SceneManager.load_level(selected_map)
	
func exit_game() -> void:
	get_tree().quit()
