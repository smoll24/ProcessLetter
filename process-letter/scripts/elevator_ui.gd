extends CanvasLayer

func _process(_delta):
	if Globals.in_elevator:
		self.visible = true
	else:
		self.visible = false
		
		

func _on_cancel_pressed() -> void:
	Globals.in_elevator = false
	Globals.can_move = true
	Globals.can_talk = true


func _on_level_a_pressed() -> void:
	pass # Replace with function body.


func _on_level_1_pressed() -> void:
	pass # Replace with function body.


func _on_level_2_pressed() -> void:
	pass # Replace with function body.


func _on_level_3_pressed() -> void:
	pass # Replace with function body.
