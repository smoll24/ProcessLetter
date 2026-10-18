extends Control

@onready var textbox = $TextEdit
@onready var win_message = $Win

const PASSWORD = "twice"

var text = ""

func _process(_delta: float) -> void:
	text = textbox.text

func _on_next_pressed() -> void:
	Click.play()
	#Go to workshop
	#Reset puzzle to network
	Globals.puzzle_step = 0
	Globals.in_computer = false
	Globals.can_move = true
	Globals.can_talk = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _on_next_mouse_entered() -> void:
	Hover.play()
	
func check_solution():
	if text == PASSWORD:
		return true
	else:
		return false

func _on_check_pressed() -> void:
	Click.play()
	var solution = check_solution()
	if solution == true:
		win_message.visible = true
		$Success.play()
		Globals.puzzle_step = 0
		Globals.ending = true
	else:
		win_message.visible = false
		Incorrect.play()
	
func _on_check_mouse_entered() -> void:
	Hover.play()
