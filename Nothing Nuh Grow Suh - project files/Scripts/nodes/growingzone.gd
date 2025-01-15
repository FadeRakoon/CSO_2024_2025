class_name GrowZone
extends Area2D
#obsolete but not removed yet 
@onready var plant_animation = $plant


@onready var plant_scene = $Plant
var plantgrowing = false #initially plant is not growing hence false
var plant_grown = false #plant grown is false initially
@onready var player: Player = get_node("/root/MainScene/LevelRoot/Game/Player")
@onready var map_manager: MapManager = get_parent()
var cell_pos: Vector2i
var plant_queue: Array[DataTypes.Plants] = []
var interactable: bool = false
var tile_placed: Tile


func _ready() -> void:
	plant_animation.play("None")
	cell_pos = map_manager.grass_layer.local_to_map(position)
	tile_placed = map_manager.tile_dict.get(cell_pos)
	
func _process(delta: float) -> void:
	plant_grown = plant_scene.grown
	
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_aoi"):
		interactable = true
#updates the appropriate states when the tile is within the player's area of influence

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player_aoi"):
		interactable = false
#updates the appropriate states when the tile leaves the player's area of influence
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click") and interactable and ActionManager.has_actions(): 
		#clicking does a lot so this block handles everything
		if plant_grown:
			#print("done")
			harvest_crop() 
		elif player.current_tool == DataTypes.Tools.TillGrass:
			reset_plant() #the player can use the till tool on a plant to remove it
		elif player.current_tool == DataTypes.Tools.PlantCrops and CostManager.can_afford_plant(player.current_plant):
			plant_crop()
	
func plant_crop():
	if not plantgrowing and map_manager.nature_tiles.get_cell_source_id(cell_pos) == -1:
	#checks first if the tile is occupied by either another plant or something on the nature tile
		if tile_placed.tile_info.fertility <= 0:
			print("soil infertile cannot plant")
		elif player.current_plant != DataTypes.Plants.None and player.current_plant!=DataTypes.Plants.Trees:
			#plant a crop if the soil is fertile and a plant is avaiable to be planted
			
			#plant_animation.play(str(DataTypes.Plants.find_key(plant)))
			plantgrowing = true
			plant_scene.set_crop(player.current_plant)
			plant_queue.append(player.current_plant) #adds the plant to the queue
			tile_placed.tile_info.fertility -= 2 #planting anything takes 2 fertility from the soil
			ActionManager.action_performed.emit()
	elif not plant_grown:
		print("plant is already growing here")

func harvest_crop():
	update_crop_rotation() 
	plant_scene.harvest()
	reset_plant() #removes the plant when done

func update_crop_rotation():
	if plant_queue.size() >= 2:
		if plant_queue.slice(-2, 0).all(func(x): return x == plant_queue[-1]): 
			#checks the the two most recently planted crops are the same
			#using all() and slice() for balance updates later if necessary
			tile_placed.tile_info.fertility -= 2
			#removes another 2 fertility if you plant the same crop twice
			#print("unrotated")
		else:
			tile_placed.tile_info.fertility += 3
			#adds 3 fertility if you rotate crops giving the player a net positive in fertility
			#print("rotated")
	if plant_queue.size() > 3:
		plant_queue.pop_front() #queue only needs to store past 3 plants
	#print(plant_queue)

func reset_plant():
	plantgrowing = false
	plant_grown = false
	plant_scene.set_crop(DataTypes.Plants.None)
	ActionManager.action_performed.emit() #emits an action on harvest and ond destroying plant
	#plant_animation.play("None")
