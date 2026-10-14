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
	preload("res://assets/puzzles/sudoku/sud02.png"),
	preload("res://assets/puzzles/sudoku/sud12.png"),
	preload("res://assets/puzzles/sudoku/sud22.png"),
	preload("res://assets/puzzles/sudoku/sud32.png"),
	preload("res://assets/puzzles/sudoku/sud42.png"),
	preload("res://assets/puzzles/sudoku/sud52.png"),
	preload("res://assets/puzzles/sudoku/sud62.png"),
	preload("res://assets/puzzles/sudoku/sud72.png"),
	preload("res://assets/puzzles/sudoku/sud82.png"),
	preload("res://assets/puzzles/sudoku/sud92.png")
]

var hover_textures = [
	preload("res://assets/puzzles/sudoku/sud0hover2.png"),
	preload("res://assets/puzzles/sudoku/sud1hover2.png"),
	preload("res://assets/puzzles/sudoku/sud2hover2.png"),
	preload("res://assets/puzzles/sudoku/sud3hover2.png"),
	preload("res://assets/puzzles/sudoku/sud4hover2.png"),
	preload("res://assets/puzzles/sudoku/sud5hover2.png"),
	preload("res://assets/puzzles/sudoku/sud6hover2.png"),
	preload("res://assets/puzzles/sudoku/sud7hover2.png"),
	preload("res://assets/puzzles/sudoku/sud8hover2.png"),
	preload("res://assets/puzzles/sudoku/sud9hover2.png")
]

var focus_textures = [
	preload("res://assets/puzzles/sudoku/sud0select2.png"),
	preload("res://assets/puzzles/sudoku/sud1select2.png"),
	preload("res://assets/puzzles/sudoku/sud2select2.png"),
	preload("res://assets/puzzles/sudoku/sud3select2.png"),
	preload("res://assets/puzzles/sudoku/sud4select2.png"),
	preload("res://assets/puzzles/sudoku/sud5select2.png"),
	preload("res://assets/puzzles/sudoku/sud6select2.png"),
	preload("res://assets/puzzles/sudoku/sud7select2.png"),
	preload("res://assets/puzzles/sudoku/sud8select2.png"),
	preload("res://assets/puzzles/sudoku/sud9select2.png")
]

var disabled_textures = [
	preload("res://assets/puzzles/sudoku/sud02.png"),
	preload("res://assets/puzzles/sudoku/sud1disabled.png"),
	preload("res://assets/puzzles/sudoku/sud2disabled.png"),
	preload("res://assets/puzzles/sudoku/sud3disabled.png"),
	preload("res://assets/puzzles/sudoku/sud4disabled.png"),
	preload("res://assets/puzzles/sudoku/sud5disabled.png"),
	preload("res://assets/puzzles/sudoku/sud6disabled.png"),
	preload("res://assets/puzzles/sudoku/sud7disabled.png"),
	preload("res://assets/puzzles/sudoku/sud8disabled.png"),
	preload("res://assets/puzzles/sudoku/sud9disabled.png")
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
	#if Globals.phase == 1:
		#for x in GRID_SIZE:
			#var column: Array = []
			#column.resize(GRID_SIZE)
			#column.fill(0)
			#number_grid.append(column)
	if phase == 0:
		#Puzzle 1
		number_grid = [[9,0,3,2,0,0,0,0,4],
					  [2,1,0,4,3,8,0,6,0],
					  [8,4,0,0,5,0,2,1,0],
					  [0,8,2,5,0,4,1,9,6],
					  [6,0,0,0,0,0,0,0,7],
					  [7,9,4,3,6,0,8,2,0],
					  [0,7,8,0,9,0,0,3,2],
					  [0,3,0,8,2,6,0,7,1],
					  [1,0,0,0,0,3,9,0,8]]
	elif phase == 1:
		#Puzzle 31
		number_grid = [[0,2,0,5,0,8,0,0,0],
					 [4,1,0,7,0,3,8,0,0],
					 [0,8,0,0,0,0,4,3,0],
					 [0,0,8,0,0,0,7,0,3],
					 [0,0,0,9,0,4,0,0,0],
					 [3,0,4,0,0,0,6,0,0],
					 [0,7,6,0,0,0,0,2,0],
					 [0,0,2,3,0,7,0,6,1],
					 [0,0,0,6,0,1,0,7,0]]
	else:
		#Puzzle 61
		number_grid = [[0,0,0,0,0,0,0,5,1],
					 [0,4,5,2,1,0,0,0,0],
					 [1,0,0,3,0,0,9,0,0],
					 [9,2,0,0,0,0,3,0,0],
					 [0,5,0,6,0,8,0,9,0],
					 [0,0,4,0,0,0,0,1,8],
					 [0,0,3,0,0,4,0,0,9],
					 [0,0,0,0,8,3,6,2,0],
					 [8,1,0,0,0,0,0,0,0]]
	
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
	button.texture_disabled = disabled_textures[number]
	
	if number != 0:
		button.disabled = true
	
	button.custom_minimum_size = Vector2(64, 64)
	
	button.pressed.connect(_on_grid_button_pressed.bind(pos, button))
	
	grid.add_child(button)
	return button


func check_solution() -> Array:
	return [true, "test"]

#func check_solution() -> Array:
	#var message
	#
	#var zero_count = 0
	#for row in number_grid:
		#zero_count += row.count(0) 
	#if zero_count != 0:
		#message = "Grid not filled"
		#return [false, message]
		#
	#for i in range(9):
		#var row_numbers = {}
		#var column_numbers = {}
		#
		#for j in range(9):
			#var row_num = number_grid[i][j]
			#var column_num = number_grid[j][i]
			#
			## Duplicate in row
			#if row_num in row_numbers:
				#message = "Duplicate in row"
				#return [false, message]
			## Duplicate in column
			#if column_num in column_numbers:
				#message = "Duplicate in column"
				#return [false, message]
			#row_numbers[row_num] = true
			#column_numbers[column_num] = true
	#
	## Check 3x3
	#for box_row in range(0, 9, 3):
		#for box_col in range(0, 9, 3):
			#var box_numbers = {}
			#
			#for i in range(3):
				#for j in range(3):
					#var num = number_grid[box_row + i][box_col + j]
					#if num in box_numbers:
						#message = "Duplicate in 3x3"
						#return [false, message]
					#box_numbers[num] = true
	#message = "Correct!"
	#return [true, message]

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



func _on_next_pressed() -> void:
	Click.play()
	Globals.current_puzzle = "logic"


func _on_reset_pressed() -> void:
	Click.play()
	get_tree().reload_current_scene()


func _on_check_pressed() -> void:
	Click.play()
	var solution = check_solution()
	label.text = solution[1]
	if solution[0] == true:
		win_message.visible = true
		Correct.play()
	else:
		Incorrect.play()


func _on_reset_mouse_entered() -> void:
	Hover.play()

func _on_check_mouse_entered() -> void:
	Hover.play()

func _on_next_mouse_entered() -> void:
	Hover.play()
