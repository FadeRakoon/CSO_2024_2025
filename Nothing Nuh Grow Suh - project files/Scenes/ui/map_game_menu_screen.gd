extends CanvasLayer
var isMapSelected:bool = false
var isclicked: bool = false

func _on_start_game_button_pressed() -> void:
	if isMapSelected :
		GameManager.start_game()
		queue_free()

func _on_exit_pressed() -> void:
	GameManager.exit_game()

func _on_jamaica_map_pressed() -> void:
	#GameManager.Map_select(DataTypes.map.Jamaica)
	if not isclicked:
		isMapSelected = true
		isclicked = true
		GameManager.Map_select("Jamaica")

func _on_barbados_map_pressed() -> void:
	#GameManager.Map_select(DataTypes.map.Barbados)
	if not isclicked:
		isMapSelected = true
		isclicked = true
		SceneManager.Map_select("Barbados")

func _on_trinidad_map_pressed() -> void:
	#GameManager.Map_select(DataTypes.map.Trinidad)
	if not isclicked:
		isMapSelected = true
		isclicked = true
		SceneManager.Map_select("Trinidad")
