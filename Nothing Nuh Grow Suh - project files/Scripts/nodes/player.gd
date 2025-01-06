class_name Player
extends CharacterBody2D

#player class used to store information about the player: direction facing and tool selected

var player_direction: Vector2
@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
@export var current_plant: DataTypes.Plants = DataTypes.Plants.None
@export var current_build: DataTypes.Builds = DataTypes.Builds.None
#export variable to allow for control when debugging
#starts the player off with no tool

func _ready():
	ToolManager.connect("tool_selected", _on_tool_selected)
	PlantManager.connect("plant_selected", _on_plant_selected)
	BuildManager.connect("build_selected", _on_build_selected)

func _on_tool_selected(tool: DataTypes.Tools) -> void:
	current_tool = tool

func _on_plant_selected(plant: DataTypes.Plants) -> void:
	current_plant = plant
	
func _on_build_selected(build: DataTypes.Builds) -> void:
	current_build = build
