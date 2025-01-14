extends Node

var main_scene_path: String = "res://Scenes/main_scene.tscn" #path to main scene
var main_scene_level_root_path: String = "/root/MainScene/LevelRoot" #path to main scene level root node
var MapSelect_scene_path: String = "res://Scenes/ui/Map_game_menu_screen.tscn" #path to map select scene


#dictionary with paths to each "level"
var level_scenes : Dictionary ={
	"Jamaica" : "res://Scenes/maps/jamaica.tscn",
	"Barbados" : "res://Scenes/maps/barbados.tscn",
	"Trinidad" : "res://Scenes/maps/trinidad.tscn",
	
}

#var level_scenes : Dictionary ={
	#DataTypes.map.Barbados : "res://Scenes/maps/barbados.tscn",
	#DataTypes.map.Trinidad : "res://Scenes/maps/trinidad.tscn",
	#DataTypes.map.Jamaica : "res://Scenes/maps/jamaica.tscn",
#}

#loads the main scene itself (since it is the main menu we want them to see the menu first)
func load_main_scene_container() -> void:
	var node: Node = load(main_scene_path).instantiate()
	
	if node != null: 
	#if there is a node already there we go to the root of the scene tree and call our node there
		get_tree().root.add_child(node)

#loads the map select version of the menu
func load_mapSelect_scene_container() -> void:
	var node: Node = load(MapSelect_scene_path).instantiate()
	
	if node!=null:
		get_tree().root.add_child(node)

#var selected_map: DataTypes.map = DataTypes.map.None
#signal map_selected (map: DataTypes.map) #declaration for signal to get what button user pressed on map selection
#func Map_select (map: DataTypes.map) -> void:
	#map_selected.emit(map)
	#selected_map = map
	
var selected_map: String
signal map_selected (map: String) #declaration for signal to get what button user pressed on map selection
func Map_select (map: String) -> void:
	map_selected.emit(map)
	selected_map = map

func load_level() -> void:
	
	var level:String
	print ("level check1: ",level)
	print ("map check1: ",selected_map)
	load_mapSelect_scene_container()
	queue_free()
	#await map_selected
	
	#match selected_map:
		#DataTypes.map.Jamaica:
			#level = "Jamaica"
		#DataTypes.map.Barbados:
			#level = "Barbados"
		#DataTypes.map.Trinidad:
			#level = "Trinidad"
	level = selected_map
	print ("level check2: ",level)
	print ("map check2: ",selected_map)
	
	var scene_path: String = level_scenes.get(level)
	print("Scene path check1: ", scene_path)
	#print("Scene: ",level_scenes.get(level)) #debug
	#var scene_path: String = level_scenes.get(level)
	
	#if scene path empty then we cant load it
	if scene_path == null:
		return
		
	var level_scene: Node = load(scene_path).instantiate()
	var level_root: Node = get_node(main_scene_level_root_path)
	
	if level_root != null:
		var nodes = level_root.get_children()
		
		if nodes != null: 
			#if we are loading a level and there is already a level loaded
			#clear out the old level so the new one can be shown
			#for each node of type node in the list of nodes...
			for node: Node in nodes:
				node.queue_free()
				#effectively delete the node
			#once we sure there is nothing else there we load the new scene
			level_root.add_child(level_scene)

#swaps scenes to load different "levels"
#func load_level(level : String) -> void:
	#
	#print("Scene: ",level_scenes.get(level)) #debug
	#var scene_path: String = level_scenes.get(level)
	#
	##if scene path empty then we cant load it
	#if scene_path == null:
		#return
		#
	#var level_scene: Node = load(scene_path).instantiate()
	#var level_root: Node = get_node(main_scene_level_root_path)
	#
	#if level_root != null:
		#var nodes = level_root.get_children()
		#
		#if nodes != null: 
			##if we are loading a level and there is already a level loaded
			##clear out the old level so the new one can be shown
			##for each node of type node in the list of nodes...
			#for node: Node in nodes:
				#node.queue_free()
				##effectively delete the node
			##once we sure there is nothing else there we load the new scene
			#level_root.add_child(level_scene)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
