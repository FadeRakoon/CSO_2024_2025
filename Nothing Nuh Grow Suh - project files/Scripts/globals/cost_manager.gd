extends Node



func can_afford_plant(plant_type: DataTypes.Plants, is_small = false) -> bool:
	var resource_path
	if plant_type == DataTypes.Plants.Trees:
		resource_path = "res://Resource Files/Plants/Tree_Small.tres" if is_small else "res://Resource Files/Plants/Tree_Large.tres"
	else:
		resource_path = "res://Resource Files/Plants/" + DataTypes.Plants.keys()[plant_type] + ".tres" 
	#load and create a copy of the resource
	var plant_instance = load(resource_path).duplicate() 
	var affordable = Global.coin >= plant_instance.cost
	if not affordable:
		print("Not enough coins to plant")
	return affordable
