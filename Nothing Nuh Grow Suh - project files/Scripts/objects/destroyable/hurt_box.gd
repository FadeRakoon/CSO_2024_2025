class_name HurtBox
extends Area2D

@onready var player: Player = get_node("/root/Game/Player") #obtains the payer node
var tool: DataTypes.Tools = DataTypes.Tools.None
var required_tool: DataTypes.Tools
#delaring current tool and required tool variables
var interactable: bool = false
var active: bool = false
#boolean flags to keep track of player interaction with the object
signal hurt
signal burn
#declaring hurt signal

func _ready() -> void:
	required_tool = get_parent().required_tool
	#obtains the object's required tool from the object node which parents the hurt box
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_aoi"):
		interactable = true #raises this flag when object is in the player's sphere of influence

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player_aoi"): 
		interactable = false #lowers the flag when the player's sphere of influence leaves the object

func _on_mouse_entered() -> void:
	if interactable:
		active = true #raises this flag when the mouse enters the hurtbox. This is only raised if the object is in the player's sphere of influence

func _on_mouse_exited() -> void:
	active = false #lowers this flag when the mouse leaves the hurtbox
	
func _process(_delta: float) -> void:
	if player: #checks if the player node was found
		tool = player.current_tool #obtains the tool the player is using
	if Input.is_action_just_pressed("tile_select") and interactable and active:
		#this if block applies the damage to the object when the object is hit (clicked by the mouse)
		var dmg_value = DataTypes.tool_dmg.get(tool)
		if tool == DataTypes.Tools.BurnWood:
			if dmg_value: #checks if the associated tool has a damage value 
				if ActionManager.has_actions():	
					burn.emit(dmg_value)
		elif (required_tool and tool == required_tool) or not required_tool:
			#looks up the damage value of the tool 
			if dmg_value: #checks if the associated tool has a damage value 
				if ActionManager.has_actions():
					hurt.emit(dmg_value) #emits the hurt signal along with how much damage the tool did
				#whatever function was connected to this signal (on_hurt in the object script) will have the damage value passed to it
	
