extends Node

var disaster_type: DataTypes.Disaster = DataTypes.Disaster.None

signal disaster_occured(disaster: DataTypes.Disaster)

func disaster_warn(disaster: DataTypes.Disaster):
	disaster_occured.emit(disaster)
	disaster_type = disaster
	DisasterNotif.disasterDisplay(disaster_type)


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
