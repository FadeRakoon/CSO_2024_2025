extends CanvasLayer

@onready var coin_label: Label = $CoinCount 

func _process(delta: float) -> void:
	var global_script = get_node("/root/Global")
	if global_script:
		coin_label.text = str(global_script.coin)
	else:
		print("global script not found")
	
	


	
