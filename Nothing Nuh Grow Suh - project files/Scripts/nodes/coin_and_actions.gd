extends CanvasLayer

@onready var coin_label: Label = $CoinCount 
@onready var actions_count: Label = $ActionsCount

func _process(delta: float) -> void:
	coin_label.text = str(Global.coin)
	actions_count.text = str(ActionManager.action_count)
	



	
