class_name Player
extends CharacterBody2D

#player class used to store information about the player: direction facing and tool selected

var player_direction: Vector2
@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
#export variable to allow for control when debugging
#starts the player off with no tool

@export var inv: Inv #connects to inventory class, so player now has inventory attached

#func collect(item):
	#inv.insert(item) #passes item to inventory 
	
func player():
	pass
	
#func collect(item): #item gotten from wehre item is collected
	#inv.insert(item) #puttig item in player inventory
