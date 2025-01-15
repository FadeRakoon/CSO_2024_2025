class_name  DisasterNotif
extends PanelContainer

@onready var Acidnode: Node = $AcidRainNotif
@onready var Floodnode:Node = $FloodNotif


func disasterDisplay(disaster_type: DataTypes.Disaster):
	Floodnode.visible = false
	Acidnode.visible = false
	
	if disaster_type == DataTypes.Disaster.AcidRain:
		Acidnode.visible = true
		
	elif disaster_type == DataTypes.Disaster.Flood:
		Floodnode.visible = true
	else:
		Acidnode.visible = false
		Floodnode.visible = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
