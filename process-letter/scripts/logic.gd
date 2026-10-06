extends Control

@onready var win_message = $Win

#Drag and Drop Logic Gates

func _ready():
	init_game()
	win_message.visible = false
	
func _process(_delta):
	if Globals.puzzle_phase == 0:
		$Puzzle1.visible = true
		$Puzzle2.visible = false
		$Puzzle3.visible = false
	elif Globals.puzzle_phase == 1:
		$Puzzle1.visible = false
		$Puzzle2.visible = true
		$Puzzle3.visible = false
	elif Globals.puzzle_phase == 2:
		$Puzzle1.visible = false
		$Puzzle2.visible = false
		$Puzzle3.visible = true
		
func init_game():
	pass
	

	
	

func check_solution() -> bool:
	return true


func _on_reset_pressed() -> void:
	get_tree().reload_current_scene()


func _on_check_pressed() -> void:
	var solution = check_solution()
	if solution == true:
		win_message.visible = true


func _on_next_pressed() -> void:
	#Go to workshop
	#Reset puzzle to sudoku
	Globals.puzzle_step = 2
	Globals.current_puzzle = "sudoku"
