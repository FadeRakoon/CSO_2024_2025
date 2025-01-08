class_name GrowZone
extends Area2D

@onready var plant_animation = $plant
var plant: DataTypes.Plants #stores seed type from global variable
var plantgrowing = false #initially plant is not growing hence false
var plant_grown = false #plant grown is false initially
@onready var player: Player = get_node("/root/Game/Player")
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
	if plantgrowing == false: #gets the plant from the player if one isn't already growing
		plant = player.current_plant
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_aoi"):
		interactable = true
#updates the appropriate states when the tile is within the player's area of influence

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player_aoi"):
		interactable = false
#updates the appropriate states when the tile leaves the player's area of influence

func _on_plant_animation_finished() -> void:
	print("done")
	plant_grown = true 
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click") and interactable: 
		#clicking does a lot so this block handles everything
		if plant_grown:
			harvest_crop() 
		elif player.current_tool == DataTypes.Tools.TillGrass:
			reset_plant() #the player can use the till tool on a plant to remove it
		elif player.current_tool == DataTypes.Tools.PlantCrops:
			plant_crop()
	
func plant_crop():
	if not plantgrowing and map_manager.nature_tiles.get_cell_source_id(cell_pos) == -1:
	#checks first if the tile is occupied by either another plant or something on the nature tile
		if tile_placed.tile_info.fertility <= 0:
			print("soil infertile cannot plant")
		elif plant:
			#plant a crop if the soil is fertile and a plant is avaiable to be planted
			plantgrowing = true
			plant_animation.play(str(DataTypes.Plants.find_key(plant)))
			tile_placed.tile_info.fertility -= 2 #planting anything takes 2 fertility from the soil
	elif not plant_grown:
		print("plant is already growing here")

func harvest_crop():
	update_crop_rotation() 
	var global_script = get_node("/root/Global") #refernces global script
	Global.plant_inventory[plant] += 1 #updates the crop inventory for the player
	if plant == 1: #checks for tomato
		Global.coin +=15
	elif plant == 2: #checks for corn
		Global.coin += 10
	elif plant == 3: #checks for onion
		Global.coin += 10
	elif plant == 4: #checks for carrot
		Global.coin += 10
	elif plant == 5: #checks for potato
		Global.coin += 5
	elif plant == 6: #checks for callaloo
		Global.coin += 5
	elif plant == 7: #checks for pumpkin
		Global.coin += 5
	else:
		Global.coin += 0
	
	reset_plant() #removes the plant when done

func update_crop_rotation():
	plant_queue.append(plant) #adds the plant to the queue
	if plant_queue.size() >= 2:
		if plant_queue.slice(-2, 0).all(func(x): return x == plant_queue[-1]): 
			#checks the the two most recently planted crops are the same
			#using all() and slice() for balance updates later if necessary
			tile_placed.tile_info.fertility -= 2
			#removes another 2 fertility if you plant the same crop twice
			print("unrotated")
		else:
			tile_placed.tile_info.fertility += 3
			#adds 3 fertility if you rotate crops giving the player a net positive in fertility
			print("rotated")
	if plant_queue.size() > 3:
		plant_queue.pop_front() #queue only needs to store past 3 plants
	print(plant_queue)

func reset_plant():
	plantgrowing = false
	plant_grown = false
	plant_animation.play("None")
