extends Node


func can_afford_plant(plant_type: DataTypes.Plants) -> bool:
	var resource_path = "res://Resource Files/Plants/" + DataTypes.Plants.keys()[plant_type] + ".tres" 
	#load and create a copy of the resource
	var plant_instance = load(resource_path).duplicate()
	#bind passes a variable that will be used as the argument when a signal's observer function is called
	var affordable = Global.coin >= plant_instance.cost
	if not affordable:
		print("Not enough coins to plant")
	return affordable
