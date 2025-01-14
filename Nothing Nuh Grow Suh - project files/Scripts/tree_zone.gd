extends Area2D
#obsolete but not removed yet 
@onready var static_body_2d: StaticBody2D = $StaticBody2D
@onready var sprite = $tree_player
var tree : Resource
var can_grow : bool
var growth_factor = 1
var frame_count: int
var fertility : int
var moisture : int 
var pollution : int
var tile_placed: Tile
var plant_instance : Resource
var small_tree
var large_tree
signal free
var is_small: bool

const small_trees = preload("res://Scenes/objects/nature/small_tree.tscn")
const large_trees = preload("res://Scenes/objects/nature/large_tree.tscn")
const small_rate = 0.65

func _ready() -> void:
	static_body_2d.collision_layer = 1
	is_small = randf() < small_rate
	var map:MapManager = get_parent()
	tile_placed = map.tile_dict[map.cell_pos]
	set_can_grow(true)
	#File path for the plant resource "Resource Folder + Name of the Plant + Resource File Extension"
	var resource_path = "res://Resource Files/Plants/Tree_Small.tres" if is_small else "res://Resource Files/Plants/Tree_Large.tres"
	#Enable growth, though this could be added to the resource to avoid the need to add if or match statements for debris or other non plants that use this resource
	can_grow = true
	#load and create a copy of the resource
	plant_instance = load(resource_path).duplicate()
	
	#bind passes a variable that will be used as the argument when a signal's observer function is called
	ActionManager.night.connect(grow_plant.bind(growth_factor))
	#Set animation and initialise
	var animation_name = "small" if is_small else "large"
	sprite.animation = animation_name
	sprite.frame = 0
	sprite.set_speed_scale(0)
	sprite.play()
	frame_count = sprite.get_sprite_frames().get_frame_count(animation_name)
	 
func grow_plant(growth_mag : int):
	update_can_grow()
	if can_grow and plant_instance:
		var days_grown = plant_instance.get_days_grown()
		plant_instance.set_days_grown(days_grown + growth_mag)
		sprite.frame = plant_instance.get_current_growth_frame(frame_count)
		if sprite.frame == 2:
			small_tree = small_trees.instantiate()
			add_child(small_tree)
			small_tree.max.connect(on_max)
			static_body_2d.collision_layer = 2
		elif small_tree:
			remove_child(small_tree)
			small_tree = null
		if sprite.frame == 3:
			large_tree = large_trees.instantiate()
			add_child(large_tree)
			large_tree.max.connect(on_max)
			static_body_2d.collision_layer = 2
		elif large_tree:
			remove_child(large_tree)
			large_tree = null
		
func set_can_grow(value : bool):
	can_grow = value
	
func update_can_grow():
	fertility = tile_placed.tile_info.fertility
	moisture = tile_placed.tile_info.moisture
	pollution = tile_placed.tile_info.pollution
	set_can_grow(fertility >= plant_instance.min_fertility and moisture >= plant_instance.min_moist and pollution < 40)
	return
	
func on_max():
	free.emit()
		
		
