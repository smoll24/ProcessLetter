extends CanvasLayer

@onready var level_a_button = $VBoxContainer/LevelA
@onready var level_1_button = $VBoxContainer/Level1
@onready var level_3_button = $VBoxContainer/Level3

func _process(_delta):
	if Globals.in_elevator:
		self.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		self.visible = false
		
	if Globals.phase == 0:
		level_1_button.disabled = true
		level_3_button.disabled = true
	elif Globals.phase == 1:
		level_1_button.disabled = false
		level_3_button.disabled = true
	elif Globals.phase == 2 or Globals.phase == 3 or Globals.phase == 4:
		level_1_button.disabled = false
		level_3_button.disabled = false
		
		
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
	Click.play()
	Globals.in_elevator = false
	Globals.can_move = true
	Globals.can_talk = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
#Switch scenes and tell Globals that starting at elevator
#positon (also have option for stairs?)

func _on_level_a_pressed() -> void:
	Click.play()
	get_tree().change_scene_to_file("res://src/main/level_a.tscn")
	Globals.in_elevator = false
	Globals.can_move = true
	Globals.can_talk = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _on_level_1_pressed() -> void:
	Click.play()
	get_tree().change_scene_to_file("res://src/main/level1.tscn")


func _on_level_2_pressed() -> void:
	Click.play()


func _on_level_3_pressed() -> void:
	Click.play()
	get_tree().change_scene_to_file("res://src/main/level3.tscn")
	Globals.in_elevator = false
	Globals.can_move = true
	Globals.can_talk = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _on_level_3_mouse_entered() -> void:
	if not $VBoxContainer/Level3.disabled:
		Hover.play()


func _on_level_1_mouse_entered() -> void:
	if not $VBoxContainer/Level1.disabled:
		Hover.play()


func _on_level_a_mouse_entered() -> void:
	if not $VBoxContainer/LevelA.disabled:
		Hover.play()


func _on_cancel_mouse_entered() -> void:
	Hover.play()
