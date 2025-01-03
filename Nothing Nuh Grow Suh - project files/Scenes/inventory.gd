extends Node

#prints the number of corn and tomato
func _physics_process(delta):
	$corntext.text = str(Global.numcorn)
	$tomatotext.text = str(Global.numtomato)
	
