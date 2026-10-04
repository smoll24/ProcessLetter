extends CanvasLayer

func _process(_delta):
	if Globals.in_computer:
		self.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		self.visible = false
		


func _on_exit_pressed() -> void:
	Globals.in_computer = false
	Globals.can_move = true
	Globals.can_talk = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
