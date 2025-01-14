extends Node

var game_menu_screen = preload("res://Scenes/ui/game_menu_screen.tscn")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("game_menu"):
		show_game_menu_screen()

func show_game_menu_screen() ->void:
	var game_menu_screen_instance = game_menu_screen.instantiate()
	get_tree().root.add_child(game_menu_screen_instance)


var selected_map: DataTypes.map = DataTypes.map.None
signal map_selected (tool: DataTypes.map) #signal to get what button user pressed on map selection
func Map_select (map: DataTypes.map) -> void:
	map_selected.emit(map)
	selected_map = map


func start_game() -> void:
	#load menu
	SceneManager.load_main_scene_container()
	#laod map selection after player presses start
	SceneManager.load_mapSelect_scene_container()
	
	var map: String #string for map chosen from map selection
	
	#various failed attempts at fixing this  (dont remove)
	#match selected_map:
		#DataTypes.map.Jamaica :
			#map ="Jamaica"
		#DataTypes.map.Barbados : 
			#map = "Barbados"
		#DataTypes.map.Trinidad :
			#map = "Trinidad"
	#print ("",map)
	#await map_selected # wait for user to input map
	#assert (selected_map > 0)
	
	SceneManager.load_level(map)


	
func exit_game() -> void:
	get_tree().quit()
