class_name PlantPanel
extends PanelContainer

@onready var plant_tomato: Button = $MarginContainer/HBoxContainer/PlantTomato
@onready var plant_corn: Button = $MarginContainer/HBoxContainer/PlantCorn
@onready var plant_onion: Button = $MarginContainer/HBoxContainer/PlantOnion
@onready var plant_carrot: Button = $MarginContainer/HBoxContainer/PlantCarrot
@onready var plant_potato: Button = $MarginContainer/HBoxContainer/PlantPotato
@onready var plant_callaloo: Button = $MarginContainer/HBoxContainer/PlantCallaloo
@onready var plant_pumpkin: Button = $MarginContainer/HBoxContainer/PlantPumpkin
@onready var plant_tree: Button = $MarginContainer/HBoxContainer/PlantTree
var bounds: Rect2 #stores the area of the panel, #used to check if the mouse is within
static var ui_active: bool = false

func _ready() -> void:
	bounds = Rect2(position, size) #sets a bounding rectangle for the panel

func _process(delta: float) -> void:
	ui_active = bounds.has_point(get_local_mouse_position()) #checks if the mouse is within the panel
	#makes panel visible if current tool is the planting tool
	if ToolManager.selected_tool == DataTypes.Tools.PlantCrops:
		visible = true
	else:
		visible = false

	
func _on_plant_tomato_pressed() -> void:
	PlantManager.select_plant(DataTypes.Plants.Tomato)

func _on_plant_corn_pressed() -> void:
	PlantManager.select_plant(DataTypes.Plants.Corn)

func _on_plant_onion_pressed() -> void:
	PlantManager.select_plant(DataTypes.Plants.Onion)

func _on_plant_carrot_pressed() -> void:
	PlantManager.select_plant(DataTypes.Plants.Carrot)

func _on_plant_potato_pressed() -> void:
	PlantManager.select_plant(DataTypes.Plants.Potato)

func _on_plant_callaloo_pressed() -> void:
	PlantManager.select_plant(DataTypes.Plants.Callaloo)

func _on_plant_pumpkin_pressed() -> void:
	PlantManager.select_plant(DataTypes.Plants.Pumpkin)

func _on_plant_tree_pressed() -> void:
	PlantManager.select_plant(DataTypes.Plants.Trees)
