extends Control

@onready var grid = $GridContainer

@onready var button1 = $SelectGrid/Button1
@onready var button2 = $SelectGrid/Button2
@onready var button3 = $SelectGrid/Button3
@onready var button4 = $SelectGrid/Button4
@onready var button5 = $SelectGrid/Button5
@onready var button6 = $SelectGrid/Button6
@onready var button7 = $SelectGrid/Button7
@onready var button8 = $SelectGrid/Button8
@onready var button9 = $SelectGrid/Button9

@onready var label = $Label
@onready var win_message = $Win

var normal_textures = [
	preload("res://assets/puzzles/sudoku/sud0.png"),
	preload("res://assets/puzzles/sudoku/sud1.png"),
	preload("res://assets/puzzles/sudoku/sud2.png"),
	preload("res://assets/puzzles/sudoku/sud3.png"),
	preload("res://assets/puzzles/sudoku/sud4.png"),
	preload("res://assets/puzzles/sudoku/sud5.png"),
	preload("res://assets/puzzles/sudoku/sud6.png"),
	preload("res://assets/puzzles/sudoku/sud7.png"),
	preload("res://assets/puzzles/sudoku/sud8.png"),
	preload("res://assets/puzzles/sudoku/sud9.png")
]

var hover_textures = [
	preload("res://assets/puzzles/sudoku/sud0hover.png"),
	preload("res://assets/puzzles/sudoku/sud1hover.png"),
	preload("res://assets/puzzles/sudoku/sud2.png"),
	preload("res://assets/puzzles/sudoku/sud3.png"),
	preload("res://assets/puzzles/sudoku/sud4.png"),
	preload("res://assets/puzzles/sudoku/sud5.png"),
	preload("res://assets/puzzles/sudoku/sud6.png"),
	preload("res://assets/puzzles/sudoku/sud7.png"),
	preload("res://assets/puzzles/sudoku/sud8.png"),
	preload("res://assets/puzzles/sudoku/sud9.png")
]

var focus_textures = [
	preload("res://assets/puzzles/sudoku/sud0select.png"),
	preload("res://assets/puzzles/sudoku/sud1.png"),
	preload("res://assets/puzzles/sudoku/sud2.png"),
	preload("res://assets/puzzles/sudoku/sud3.png"),
	preload("res://assets/puzzles/sudoku/sud4.png"),
	preload("res://assets/puzzles/sudoku/sud5.png"),
	preload("res://assets/puzzles/sudoku/sud6.png"),
	preload("res://assets/puzzles/sudoku/sud7.png"),
	preload("res://assets/puzzles/sudoku/sud8.png"),
	preload("res://assets/puzzles/sudoku/sud9.png")
]

var game_grid = []
var number_grid = []
const GRID_SIZE = 9
var selected_button:TextureButton
var selected_pos:Vector2

func _ready():
	init_game()
	win_message.visible = false
	
	
func _setup_game(phase):
	number_grid = []
	if phase == 1:
		for x in GRID_SIZE:
			var column: Array = []
			column.resize(GRID_SIZE)
			column.fill(0)
			number_grid.append(column)
	elif phase == 0:
		number_grid = [[9,0,3,2,0,0,0,0,4],
					  [2,1,0,4,3,8,0,6,0],
					  [8,4,0,0,5,0,2,1,0],
					  [0,8,2,5,0,4,1,9,6],
					  [6,0,0,0,0,0,0,0,7],
					  [7,9,4,3,1,0,8,2,0],
					  [0,7,8,0,9,0,0,3,2],
					  [0,7,8,0,9,0,0,3,2],
					  [1,0,0,0,0,3,9,0,8]]
	elif phase == 2:
		number_grid = [[9,6,3,2,1,7,5,8,4],
					  [2,1,5,4,3,8,7,6,9],
					  [8,4,7,6,5,9,2,1,3],
					  [3,8,2,5,7,4,1,9,6],
					  [6,5,1,9,8,2,3,4,7],
					  [7,9,4,3,6,1,8,2,5],
					  [4,7,8,1,9,5,6,3,2],
					  [5,3,9,8,2,6,4,7,1],
					  [1,2,6,7,4,3,9,5,8]]
	
	
func init_game():
	_setup_game(Globals.puzzle_phase)
	_populate_grid()
	
func _populate_grid():
	game_grid = []
	for i in range(GRID_SIZE):
		var row = []
		for j in range(GRID_SIZE):
			row.append(create_button(Vector2(i,j)))
		game_grid.append(row)
			
func create_button(pos:Vector2):
	var button = TextureButton.new()
	var number = number_grid[int(pos[0])][int(pos[1])]
	button.texture_normal = normal_textures[number]
	button.texture_hover = hover_textures[number]
	button.texture_focused = focus_textures[number]
	
	if number != 0:
		button.disabled = true
	
	button.custom_minimum_size = Vector2(64, 64)
	
	button.pressed.connect(_on_grid_button_pressed.bind(pos, button))
	
	grid.add_child(button)
	return button


func check_solution() -> Array:
	var message
	
	var zero_count = 0
	for row in number_grid:
		zero_count += row.count(0) 
	if zero_count != 0:
		message = "Grid not filled"
		return [false, message]
		
	for i in range(9):
		var row_numbers = {}
		var column_numbers = {}
		
		for j in range(9):
			var row_num = number_grid[i][j]
			var column_num = number_grid[j][i]
			
			# Duplicate in row
			if row_num in row_numbers:
				message = "Duplicate in row"
				return [false, message]
			# Duplicate in column
			if column_num in column_numbers:
				message = "Duplicate in column"
				return [false, message]
			row_numbers[row_num] = true
			column_numbers[column_num] = true
	
	# Check 3x3
	for box_row in range(0, 9, 3):
		for box_col in range(0, 9, 3):
			var box_numbers = {}
			
			for i in range(3):
				for j in range(3):
					var num = number_grid[box_row + i][box_col + j]
					if num in box_numbers:
						message = "Duplicate in 3x3"
						return [false, message]
					box_numbers[num] = true
	message = "Correct!"
	return [true, message]

func change_button_number(number):
	Click.play()
	if selected_button != null:
		number_grid[int(selected_pos[0])][int(selected_pos[1])] = number
		selected_button.texture_normal = normal_textures[number]
		selected_button.texture_hover = hover_textures[number]
		selected_button.texture_focused = focus_textures[number]
		

func _on_grid_button_pressed(pos, button):
	Click.play()
	button.grab_focus()
	selected_button = button
	selected_pos = pos
	print("Button pressed",pos)

func _on_button_1_pressed() -> void:
	change_button_number(1)

func _on_button_2_pressed() -> void:
	change_button_number(2)

func _on_button_3_pressed() -> void:
	change_button_number(3)

func _on_button_4_pressed() -> void:
	change_button_number(4)

func _on_button_5_pressed() -> void:
	change_button_number(5)
	
func _on_button_6_pressed() -> void:
	change_button_number(6)
	
func _on_button_7_pressed() -> void:
	change_button_number(7)
	
func _on_button_8_pressed() -> void:
	change_button_number(8)
	
func _on_button_9_pressed() -> void:
	change_button_number(9)

func _on_button_0_pressed() -> void:
	change_button_number(0)



func _on_check_pressed() -> void:
	Click.play()
	var solution = check_solution()
	label.text = solution[1]
	if solution[0] == true:
		win_message.visible = true

func _on_reset_pressed() -> void:
	Click.play()
	get_tree().reload_current_scene()


func _on_next_pressed() -> void:
	Click.play()
	Globals.current_puzzle = "logic"
