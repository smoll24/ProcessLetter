extends Control

@onready var win_message = $Win

@onready var and_button = $Buttons/HBoxContainer/and_button
@onready var or_button = $Buttons/HBoxContainer/or_button
@onready var xor_button = $Buttons/HBoxContainer/xor_button
@onready var not_button = $Buttons/HBoxContainer/not_button

#and, or, xor, not
var current_gate:String = "null"

#Instead of drag and drop, do more like Sudoku
#Click the bottom button of one sets variable to "current" gate
#Then the slots for the gates are also texture buttons whose
#texturs change to match the "selected" gate
#If not chosen, doesn't change texture

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
		
	if current_gate == "and":
		and_button.disabled = true
		or_button.disabled = false
		xor_button.disabled = false
		not_button.disabled = false
	elif current_gate == "or":
		and_button.disabled = false
		or_button.disabled = true
		xor_button.disabled = false
		not_button.disabled = false
	elif current_gate == "xor":
		and_button.disabled = false
		or_button.disabled = false
		xor_button.disabled = true
		not_button.disabled = false
	elif current_gate == "not":
		and_button.disabled = false
		or_button.disabled = false
		xor_button.disabled = false
		not_button.disabled = true
		
		
func init_game():
	pass
	


func check_solution() -> bool:
	return true


func _on_reset_pressed() -> void:
	Click.play()
	get_tree().reload_current_scene()


func _on_check_pressed() -> void:
	Click.play()
	var solution = check_solution()
	if solution == true:
		win_message.visible = true


func _on_next_pressed() -> void:
	Click.play()
	#Go to workshop
	#Reset puzzle to sudoku
	Globals.puzzle_step = 2
	Globals.current_puzzle = "sudoku"


func _on_and_button_pressed() -> void:
	Click.play()
	current_gate = "and"

func _on_or_button_pressed() -> void:
	Click.play()
	current_gate = "or"

func _on_xor_button_pressed() -> void:
	Click.play()
	current_gate = "xor"

func _on_not_button_pressed() -> void:
	Click.play()
	current_gate = "not"
