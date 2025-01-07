extends Node

func _physics_process(delta):
	for plant in range(0,7):
		get_child(plant).get_child(0).text = str(Global.plant_inventory[plant + 1])
	
