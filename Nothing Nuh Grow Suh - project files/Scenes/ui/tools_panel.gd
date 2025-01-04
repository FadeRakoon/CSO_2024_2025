class_name ToolsPanel
extends PanelContainer

@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_tilling: Button = $MarginContainer/HBoxContainer/ToolTilling
@onready var tool_seeds: Button = $MarginContainer/HBoxContainer/ToolSeeds
@onready var tool_watering_can: Button = $MarginContainer/HBoxContainer/ToolWateringCan
@onready var tool_build: Button = $MarginContainer/HBoxContainer/ToolBuild
static var ui_active: bool = false
		
func _on_tool_axe_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.AxeWood)

func _on_tool_tilling_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.TillGrass)

func _on_tool_seeds_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.None)

func _on_tool_watering_can_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.WaterCrops)

func _on_tool_build_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.None)
