extends Node2D

@onready var sprite = $AnimatedSprite2D
var plant_instance : Resource
var can_grow : bool
var growth_factor = 1
var frame_count

func set_crop(plant_type : DataTypes.Plants):
	
	if plant_type == DataTypes.Plants.None:
		sprite.animation = "None"
		#Disable the growth and harvest functions of empty cells
		set_can_grow(false)
		return
	#File path for the plant resource "Resource Folder + Name of the Plant + Resource File Extension"
	var resource_path = "res://Plant Resources/" + DataTypes.Plants.keys()[plant_type] + ".tres" 
	#Enable growth, though this could be added to the resource to avoid the need to add if or match statements for debris or other non plants that use this resource
	can_grow = true
	
	#load and create a copy of the resource
	plant_instance = load(resource_path).duplicate()
	
	#bind passes a variable that will be used as the argument when a signal's observer function is called
	ActionManager.time_advanced.connect(grow_plant.bind(growth_factor))
	
	#Set animation and initialise
	sprite.animation = plant_instance.plant_name
	sprite.frame = 0
	sprite.set_speed_scale(0)
	frame_count = sprite.get_sprite_frames().get_frame_count(DataTypes.Plants.keys()[plant_type])
	
	
func grow_plant(growth_mag : int):
	if can_grow:
		var days_grown = plant_instance.get_days_grown()
		plant_instance.set_days_grown(days_grown + growth_mag)
		sprite.frame = plant_instance.get_current_growth_frame(frame_count)

# To be implemented 
func harvest():
	plant_instance.sell_plant()

func set_can_grow(value : bool):
	can_grow = value
	
func check_can_grow(fert : int, moist : int):
	pass
	