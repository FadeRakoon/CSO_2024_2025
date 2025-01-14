extends Resource
class_name crop


#Class to be used for plant resource
#This allows us to store data for plants as well as helper functions for that data
#Resources can then either be read in a script (they're files so they have to be loaded or preloaded) or instanced
#A resource shows the same info everytime it's loaded, everywhere its loaded, instancing it by using .duplicate 
#Duplication allows you to edit the values in the instance without affecting all other things that use the resource
#This is good for things like inventory items

signal plant_sold(price : int)
signal plant_destroyed

@export var plant_name : String
@export var days_grown : int
@export var growth_time : int
@export var min_fertility : int
@export var min_moist : int
@export var sell_value : int

func is_fully_grown() -> bool :
	return days_grown >= growth_time

func can_grow(tile_moist, tile_fert):
	return tile_moist >= min_moist and tile_fert >= min_fertility

func get_current_growth_frame(frame_count : int):
	#print(days_grown,"/",frame_count,"/",growth_time)
	return round(days_grown * (float(frame_count) / growth_time))

func set_days_grown(days):
	days_grown = days
	
func get_days_grown():
	return days_grown

func sell_plant():
	plant_sold.emit(sell_value)
