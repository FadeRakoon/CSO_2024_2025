class_name Player
extends CharacterBody2D

#player class used to store information about the player: direction facing and tool selected

var player_direction: Vector2
@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
#export variable to allow for control when debugging
#starts the player off with no tool

func _ready():
	ToolManager.connect("tool_selected", _on_tool_selected)

func _on_tool_selected(tool: DataTypes.Tools) -> void:
	current_tool = tool
