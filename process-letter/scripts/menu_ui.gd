extends CanvasLayer

@onready var start_button = $VBoxContainer/Start

func _ready():
	MenuBg.play()
	start_button.grab_focus()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_start_pressed() -> void:
	Click.play()
	get_tree().change_scene_to_file("res://src/main/level_a.tscn")
	MenuBg.stream_paused = true


func _on_options_pressed() -> void:
	Click.play()
	
