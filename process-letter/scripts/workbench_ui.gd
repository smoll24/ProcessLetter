extends CanvasLayer

func _process(_delta):
	if Globals.in_computer:
		self.visible = true
	else:
		self.visible = false
		
		

func _on_button_pressed() -> void:
	Globals.in_computer = false
	Globals.can_move = true
	Globals.can_talk = true
