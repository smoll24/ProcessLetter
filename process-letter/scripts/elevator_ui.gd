extends CanvasLayer

@onready var level_a_button = $VBoxContainer/LevelA

func _process(_delta):
	if Globals.in_elevator:
		self.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		self.visible = false
		
	if Globals.current_level == 0:
		$VBoxContainer2/LightA_on.visible = true
		$VBoxContainer2/LightA_off.visible = false
		$VBoxContainer2/Light1_on.visible = false
		$VBoxContainer2/Light1_off.visible = true
		$VBoxContainer2/Light3_on.visible = false
		$VBoxContainer2/Light3_off.visible = true
	elif Globals.current_level == 1:
		$VBoxContainer2/LightA_on.visible = false
		$VBoxContainer2/LightA_off.visible = true
		$VBoxContainer2/Light1_on.visible = true
		$VBoxContainer2/Light1_off.visible = false
		$VBoxContainer2/Light3_on.visible = false
		$VBoxContainer2/Light3_off.visible = true
	elif Globals.current_level == 3:
		$VBoxContainer2/LightA_on.visible = false
		$VBoxContainer2/LightA_off.visible = true
		$VBoxContainer2/Light1_on.visible = false
		$VBoxContainer2/Light1_off.visible = true
		$VBoxContainer2/Light3_on.visible = true
		$VBoxContainer2/Light3_off.visible = false
		

func _on_cancel_pressed() -> void:
	Globals.in_elevator = false
	Globals.can_move = true
	Globals.can_talk = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
#Switch scenes and tell Globals that starting at elevator
#positon (also have option for stairs?)

func _on_level_a_pressed() -> void:
	get_tree().change_scene_to_file("res://src/main/level_a.tscn")
	Globals.in_elevator = false
	Globals.can_move = true
	Globals.can_talk = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://src/main/level1.tscn")


func _on_level_2_pressed() -> void:
	pass # Replace with function body.


func _on_level_3_pressed() -> void:
	get_tree().change_scene_to_file("res://src/main/level3.tscn")
	Globals.in_elevator = false
	Globals.can_move = true
	Globals.can_talk = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
