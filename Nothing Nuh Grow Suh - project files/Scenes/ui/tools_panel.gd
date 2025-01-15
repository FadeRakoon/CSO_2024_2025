class_name ToolsPanel
extends PanelContainer

@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_tilling: Button = $MarginContainer/HBoxContainer/ToolTilling
@onready var tool_seeds: Button = $MarginContainer/HBoxContainer/ToolSeeds
@onready var tool_watering_can: Button = $MarginContainer/HBoxContainer/ToolWateringCan
@onready var tool_build: Button = $MarginContainer/HBoxContainer/ToolBuild
var bounds: Rect2 #stores the area of the panel, #used to check if the mouse is within
static var ui_active: bool = false
	
func _ready() -> void:
	bounds = Rect2(position, size) #sets a bounding rectangle for the panel

func _process(delta: float) -> void:
	ui_active = bounds.has_point(get_local_mouse_position()) #checks if the mouse is within the panel
	#var screen_size = get_viewport().size
	#get_parent().size = screen_size * 0.9  # Scale to 90% of screen
	
func _on_tool_axe_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.AxeWood)

func _on_tool_tilling_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.TillGrass)

func _on_tool_seeds_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.PlantCrops)
	PlantManager.select_plant(DataTypes.Plants.Carrot)

func _on_tool_watering_can_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.WaterCrops)
	#ToolManager.select_tool(DataTypes.Tools.BurnWood) #repurposing this button for burning for debug

func _on_tool_build_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.PlantCrops)
	PlantManager.select_plant(DataTypes.Plants.Trees)
