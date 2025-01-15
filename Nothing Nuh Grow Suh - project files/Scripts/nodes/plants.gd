extends Node2D

@onready var sprite = $AnimatedSprite2D
var plant_instance : Resource
var can_grow : bool
var growth_factor = 1
var frame_count
var grown: bool
var circumstance : bool
var fertility : int
var moisture : int 
var pollution: int
var tile_info: TileManager
var fert_const: float
var pollution_const: float

func set_crop(plant_type : DataTypes.Plants):
	tile_info = get_parent().tile_placed.tile_info
	if plant_type == DataTypes.Plants.None:
		sprite.animation = "None"
		#Disable the growth and harvest functions of empty cells
		set_can_grow(true)
		return
	#File path for the plant resource "Resource Folder + Name of the Plant + Resource File Extension"
	var resource_path = "res://Resource Files/Plants/" + DataTypes.Plants.keys()[plant_type] + ".tres" 
	#Enable growth, though this could be added to the resource to avoid the need to add if or match statements for debris or other non plants that use this resource
	can_grow = true
	circumstance = true
	
	#load and create a copy of the resource
	plant_instance = load(resource_path).duplicate()
	
	#bind passes a variable that will be used as the argument when a signal's observer function is called
	Global.coin -= plant_instance.cost
	ActionManager.night.connect(grow_plant.bind(growth_factor))
	ActionManager.time_advanced.connect(update_can_grow)
	#Set animation and initialise
	sprite.animation = plant_instance.plant_name
	sprite.frame = 0
	sprite.set_speed_scale(0)
	frame_count = sprite.get_sprite_frames().get_frame_count(DataTypes.Plants.keys()[plant_type])
	
	 
func grow_plant(growth_mag : int):
	if can_grow and plant_instance:
			var days_grown = plant_instance.get_days_grown()
			plant_instance.set_days_grown(days_grown + growth_mag)
			sprite.frame = plant_instance.get_current_growth_frame(frame_count)
			if get_parent().plantgrowing:
				tile_info.water(Global.PLANT_WATER_LOSS)
			if fertility >= 30:
				fert_const+=1
			if pollution >= 30:
				pollution_const+=1
				
# To be implemented 
func harvest():
	plant_instance.sell_value += clamp(round(3 * fert_const/plant_instance.growth_time), 0, 4) #plants can sell for up to 4 more coins depending on how long they were in fertile soil for
	plant_instance.sell_value -= clamp(round(3 * pollution_const/plant_instance.growth_time), 0, 4)
	plant_instance.sell_plant()
	Global.coin += plant_instance.sell_value
	plant_instance = null
	grown = false
	

func set_can_grow(value : bool):
	can_grow = value
	
func update_can_grow():
	if get_parent().plantgrowing:
		fertility = tile_info.fertility
		moisture = tile_info.moisture
		pollution = tile_info.pollution
		set_can_grow(fertility >= plant_instance.min_fertility and moisture >= plant_instance.min_moist and circumstance and pollution < 40)
		if not moisture >= plant_instance.min_moist:
			TextManger.say(["Plant can't grow","The soil is too dry"])
		if not fertility >= plant_instance.min_fertility:
			TextManger.say(["Plant can't grow","The soil is too infertile"])
		if not  pollution < 40:
			TextManger.say(["Plant can't grow","The soil is too polluted"])
		return
	
func calculate_sell_loss():
	pass
	
func _process(delta: float) -> void:
	if plant_instance:
		grown = plant_instance.is_fully_grown()
	
