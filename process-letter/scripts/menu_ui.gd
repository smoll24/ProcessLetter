extends CanvasLayer

@onready var start_button = $VBoxContainer/Start

func _ready():
	start_button.grab_focus()
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://src/main/level_a.tscn")


func _on_options_pressed() -> void:
	pass # Replace with function body.
