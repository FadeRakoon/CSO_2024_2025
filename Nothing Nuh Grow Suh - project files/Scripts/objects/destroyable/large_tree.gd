extends Sprite2D

#each destroyable object has an associated hurt box, and damage manager node that keeps track of their damage
@onready var hurt_box: HurtBox = $HurtBox
@onready var dmg_manager: Dmg_Manager = $Dmg_Manager
#gets the required nodes
@export var required_tool: DataTypes.Tools = DataTypes.Tools.AxeWood
#setting the destroy object to the axe for now due to asset pack limitations
#may use this scrip as a class if we get more assets
var parent
var nature_tiles: TileMapLayer
var cell_pos: Vector2i
var local_pos: Vector2
var fires = preload("res://Scenes/objects/fire_large.tscn")
#declares nodes for the nature tilemap layer of the game which holds all the destroyable objects and variables for the position of the object
signal max

func _ready() -> void:
	#initialises variables
	parent = get_parent()
	if parent is TileMapLayer:
		nature_tiles = parent#the nature tilemap is the parent of the object 
		local_pos = nature_tiles.to_local(global_position) 
		cell_pos = nature_tiles.local_to_map(local_pos)
	#gets the position on the tilemap of the obeject
	hurt_box.hurt.connect(on_hurt)
	hurt_box.burn.connect(on_burn)
	#the hurt box holds a hurt signale emitted when the object takes damage
	dmg_manager.max_dmg_reached.connect(on_max)
	#the damange manager holds a max damage reached signal emitted to destroy the object when the object takes its max allowed damange
	return 
	
func on_hurt(hit_dmg: int) -> void:
	#print("hit") #debug statement
	var timer = get_tree().create_timer(1.0)
	ActionManager.action_performed.emit()
	dmg_manager.apply_dmg(hit_dmg)
	#damage manager has the function apply damage that updates the amount of damange the object has taken
	material.set_shader_parameter("shake_intensity", 1.0)
	await timer.timeout
	material.set_shader_parameter("shake_intensity", 0.0)
	#a shader has been applied to the object that shakes it
	#this chunk of code changes the shake_intensity parameter of the shader and sets it back to 0 after 1 second
	
func on_burn(tick_dmg: int) -> void:
	modulate = Color(0.5, 0.5, 0.5, 1.0)
	var fire = fires.instantiate()
	fire.position = Vector2(0,4)
	add_child(fire)
	ActionManager.action_performed.emit()
	var tree = get_tree()
	for i in range(0, dmg_manager.max_dmg):
		var timer = tree.create_timer(0.7)
		dmg_manager.apply_dmg(tick_dmg)
		#print("tick")
		await timer.timeout
	
func on_max() -> void:
	#print("Max dmg") #debug statement
	if nature_tiles:
		nature_tiles.set_cell(cell_pos, -1, Vector2i(0,0), 0) #clears the tile on the nature layer
		queue_free() #deletes the object
	else:
		max.emit()
