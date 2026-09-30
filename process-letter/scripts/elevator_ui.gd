extends CanvasLayer

@onready var level_a_button = $VBoxContainer/LevelA


func _process(_delta):
	if Globals.in_elevator:
		self.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		self.visible = false
		
		

func _on_cancel_pressed() -> void:
	Globals.in_elevator = false
	Globals.can_move = true
	Globals.can_talk = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
#Switch scenes and tell Globals that starting at elevator
#positon (also have option for stairs?)

func _on_level_a_pressed() -> void:
	get_tree().change_scene_to_file("res://src/main/level_a.tscn")


func _on_level_1_pressed() -> void:
	pass # Replace with function body.


func _on_level_2_pressed() -> void:
	pass # Replace with function body.


func _on_level_3_pressed() -> void:
	pass # Replace with function body.
