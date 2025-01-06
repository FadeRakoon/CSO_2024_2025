class_name ToolsPanel
extends PanelContainer

@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_tilling: Button = $MarginContainer/HBoxContainer/ToolTilling
@onready var tool_seeds: Button = $MarginContainer/HBoxContainer/ToolSeeds
@onready var tool_watering_can: Button = $MarginContainer/HBoxContainer/ToolWateringCan
@onready var tool_build: Button = $MarginContainer/HBoxContainer/ToolBuild
var bounds: Rect2 #stores the area of the panel, #used to check if the mouse is within
static var ui_active: bool = false

static  func using_ui() -> bool:
	return ui_active
	
func _ready() -> void:
	bounds = Rect2(global_position, size) #sets a bounding rectangle for the panel
	
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

func _process(delta: float) -> void:
	var mouse_pos = get_local_mouse_position()
	if bounds.has_point(mouse_pos): #checks if the mouse is within the panel
		ui_active = true
	else:
		ui_active = false
