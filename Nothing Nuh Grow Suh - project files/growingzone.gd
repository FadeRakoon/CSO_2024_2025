extends StaticBody2D

var plant = Global.plantselected #stores seed type from global variable
var plantgrowing = false #initially plant is not growing hence false
var plant_grown = false #plant grown is false initially

func _physics_process(delta: float) -> void:
	#print(Global.plantselected)
	if plantgrowing == false: #if the plant is not growing
		plant = Global.plantselected 

func _on_area_2d_area_entered(area: Area2D) -> void:
	if not plantgrowing:
		if plant == 1: #if the plant is corn
			plantgrowing = true #now a plant is growing, so true
			$corngrowtimer.start() #starts growth timer
			$plant.play("corn_growing") #plays corn growing animation
		if plant == 2: # if plant is tomato
			plantgrowing = true
			$tomatogrowtimer.start() #starts growth timer
			$plant.play("tomato_growing") #plays tomato growing animation
	else:
		print("plant is already growing here") #makes sure multiple plants aren't planted in the same spot
		
func _on_corngrowtimer_timeout() -> void:
	var corn_plant = $plant
	if corn_plant.frame == 0: #first frame of growing
		corn_plant.frame = 1
		$corngrowtimer.start() #resets timer 
	elif corn_plant.frame == 1:
		corn_plant.frame = 2 
		$corngrowtimer.start()
	elif corn_plant.frame == 2:
		corn_plant.frame = 3
		plant_grown = true #plant is fully grown

func _on_tomatogrowtimer_timeout() -> void:
	var tomato_plant = $plant
	if tomato_plant.frame == 0: #first frame of growing
		tomato_plant.frame = 1
		$tomatogrowtimer.start() #resets timer 
	elif tomato_plant.frame == 1:
		tomato_plant.frame = 2 
		$tomatogrowtimer.start()
	elif tomato_plant.frame == 2:
		tomato_plant.frame = 3
		plant_grown = true #plant is fully grown


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		if plant_grown:
			if plant == 1: #if the plant is corn
				Global.numcorn += 1
				plantgrowing = false
				plant_grown = false
				$plant.play("none")
			if plant == 2: #if the plant is tomato
				Global.numtomato += 1
				plantgrowing = false
				plant_grown = false
				$plant.play("none")
			else:  #if it's not any of our possible crops
				pass
		print(str(Global.numcorn))
		print(str(Global.numtomato))
