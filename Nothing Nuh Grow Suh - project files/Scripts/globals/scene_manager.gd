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

#loads the main scene itself (since it is the main menu we want them to see the menu first)
func load_main_scene_container() -> void:
	var node: Node = load(main_scene_path).instantiate()
	
	if node != null: 
	#if there is a node already there we go to the root of the scene tree and call our node there
		get_tree().root.add_child(node)

#swaps scenes to load different "levels"
func load_level(selected_map :String) -> void:
	var scene_path: String = level_scenes.get(selected_map)
	
	#print("Scene path check1: ", scene_path)
	
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
