extends Node

func _physics_process(delta):
	$corntext.text = str(Global.numcorn)
	$tomatotext.text = str(Global.numtomato)
	
