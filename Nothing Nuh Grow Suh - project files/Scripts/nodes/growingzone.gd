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

func _ready() -> void:
	plant_animation.play("None")
	cell_pos = map_manager.grass_layer.local_to_map(position)
	
func _process(delta: float) -> void:
	#print(Global.plantselected)
	if plantgrowing == false: #if the plant is not growing
		plant = player.current_plant
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_aoi"):
		interactable = true
#updates the appropriate states when the tile is within the player's area of influence

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player_aoi"):
		interactable = false
#updates the appropriate states when the tile leaves the player's area of influence

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var tile_placed: Tile = map_manager.tile_dict.get(cell_pos)
	if Input.is_action_just_pressed("click") and interactable:
		if not plantgrowing and map_manager.nature_tiles.get_cell_source_id(cell_pos) == -1:
			if plant: #if the plant is corn
				plantgrowing = true #now a plant is growing, so true
				plant_animation.play(str(DataTypes.Plants.find_key(plant))) #plays corn growing animation
			if tile_placed.tile_info.fertility <= 0:
				print("soil infertile")
		elif not plant_grown:
			print("plant is already growing here") #makes sure multiple plants aren't planted in the same spot
		if plant_grown:
			#crop rotation
			plant_queue.append(plant)
			if plant_queue.size() > 3:
				plant_queue.pop_front()
			elif plant_queue.size() >= 2:
				if plant_queue.slice(-2,0).all(func (x): return x == plant_queue[0]):
					#checks if the last 2 crops to be planted are the same and decreases fertility of soil
					tile_placed.tile_info.fertility -= 5
					print("unrotated")
				else: 
					tile_placed.tile_info.fertility += 3
					print("rotated")
			print(plant_queue)
			#section that deals with plant queue and crop rotation
			
			Global.plant_inventory[plant] += 1
			plant_grown = false
			plant_animation.play("None")
			plantgrowing = false
		elif player.current_tool == DataTypes.Tools.TillGrass:
			plantgrowing = false
			plant_grown = false
			plant_animation.play("None")

func _on_plant_animation_finished() -> void:
	print("done")
	plant_grown = true
