extends CanvasLayer

@onready var network = $Network
@onready var sudoku = $Sudoku

func _process(_delta):
	if Globals.in_computer:
		self.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		self.visible = false
	
	if Globals.current_puzzle == "network":
		network.visible = true
		sudoku.visible = false
	elif Globals.current_puzzle == "sudoku":
		network.visible = false
		sudoku.visible = true


func _on_exit_pressed() -> void:
	Globals.in_computer = false
	Globals.can_move = true
	Globals.can_talk = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
