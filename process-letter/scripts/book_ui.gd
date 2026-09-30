extends CanvasLayer

func _process(_delta):
	if Globals.in_book:
		self.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		self.visible = false
		
		

func _on_button_pressed() -> void:
	Globals.in_book = false
	Globals.can_move = true
	Globals.can_talk = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
