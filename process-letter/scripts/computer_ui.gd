extends CanvasLayer

@onready var network = $Network
@onready var sudoku = $Sudoku
@onready var logic = $Logic
@onready var password = $Password

func _process(_delta):
	if Globals.in_computer or Globals.in_workbench:
		LevelABg.stream_paused = true
		WorkshopBg.stream_paused = false
		Office.stream_paused = true
	else:
		LevelABg.stream_paused = false
		WorkshopBg.stream_paused = true
		Office.stream_paused = false
	
	if Globals.in_computer:
		self.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		self.visible = false
	
	if Globals.current_puzzle == "network":
		network.visible = true
		sudoku.visible = false
		logic.visible = false
		password.visible = false
	elif Globals.current_puzzle == "sudoku":
		network.visible = false
		sudoku.visible = true
		logic.visible = false
		password.visible = false
	elif Globals.current_puzzle == "logic":
		network.visible = false
		sudoku.visible = false
		logic.visible = true
		password.visible = false
	elif Globals.current_puzzle == "password":
		network.visible = false
		sudoku.visible = false
		logic.visible = false
		password.visible = true

func reload_scene():
	Globals.reloading = true
	Globals.stored_player_position = Globals.player_position
	get_tree().change_scene_to_file("res://src/main/level_a.tscn")

func _on_exit_pressed() -> void:
	Click.play()
	Globals.in_computer = false
	Globals.can_move = true
	Globals.can_talk = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	if Globals.puzzle_step == 2:
		if Globals.phase < 3:
			Globals.current_puzzle = "network"
		else:
			Globals.current_puzzle = "password"
	if Globals.ending:
		reload_scene()


func _on_exit_mouse_entered() -> void:
	Hover.play()
