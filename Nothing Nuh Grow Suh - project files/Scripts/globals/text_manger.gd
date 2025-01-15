extends Node


@onready var text_box_scene = preload("res://Scenes/ui/text_box.tscn")

var dialog_lines: Array[String] = []
var current_line_index = 0


var text_box
var text_box_position: Vector2
var player_position: Vector2
var is_dialog_active = false
var can_advance_line = false

func say(lines: Array[String]):
	if is_dialog_active:
		return
	dialog_lines = lines
	text_box_position = player_position
	_show_text_box()
	
	is_dialog_active = true
	
func _show_text_box():
	text_box = text_box_scene.instantiate()
	text_box.finished_displaying.connect(_on_text_box_finsished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(dialog_lines[current_line_index])
	can_advance_line = false

func _on_text_box_finsished_displaying():
	can_advance_line = true
	
func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("advance_dialog") and is_dialog_active and can_advance_line):
		text_box.queue_free()
		current_line_index += 1
		if current_line_index >= dialog_lines.size():
			is_dialog_active = false
			current_line_index = 0
			return 
		_show_text_box()
		
func _process(delta: float) -> void:
	player_position = Player.export_postion
	#print(player_position)
		
