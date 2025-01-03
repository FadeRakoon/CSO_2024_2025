extends Node

func _physics_processes(delta):
	$corntext.text = str(Global.numcorn)
	$tomatotext.text = str(Global.numtomato)
	
