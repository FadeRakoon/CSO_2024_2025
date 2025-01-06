extends Node

var selected_plant: DataTypes.Plants = DataTypes.Plants.None

signal plant_selected(plant: DataTypes.Plants)

func select_plant(plant: DataTypes.Plants) -> void:
	plant_selected.emit(plant)
	selected_plant = plant
