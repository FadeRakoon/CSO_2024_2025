extends CanvasLayer


@onready var BgMusic:AudioStreamPlayer = $Background_Music

func _on_mute_music_pressed() -> void:
	if BgMusic.is_playing():
		BgMusic.stop()
	else:
		BgMusic.play()
