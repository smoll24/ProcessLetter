extends Control

@onready var win_message = $Win

@onready var and_button = $Buttons/HBoxContainer/and_button
@onready var or_button = $Buttons/HBoxContainer/or_button
@onready var xor_button = $Buttons/HBoxContainer/xor_button

const TARGET_OUTPUT = 1
const GATE_NAMES = ["and", "or", "xor"]

#Instead of drag and drop, do more like Sudoku
#Click the bottom button of one sets variable to "current" gate
#Then the slots for the gates are also texture buttons whose
#texturs change to match the "selected" gate
#If not chosen, doesn't change texture

#Draw lines between the gates, green if 1, and white if 0
# Gate selections are stored separately for each puzzle phase.
# A value of "" means the slot has not been filled.

var gate_selections = {
	0: {1: "", 2: "", 3: ""},
	1: {1: "", 2: "", 3: ""},
	2: {1: "", 2: "", 3: "", 4: ""}
}

var normal_textures = [
	preload("res://assets/puzzles/logic/and_normal.png"),
	preload("res://assets/puzzles/logic/or_normal.png"),
	preload("res://assets/puzzles/logic/xor_normal.png"),
]

var hover_textures = [
	preload("res://assets/puzzles/logic/and_hover.png"),
	preload("res://assets/puzzles/logic/or_hover.png"),
	preload("res://assets/puzzles/logic/xor_hover.png"),
]

var focus_textures = [
	preload("res://assets/puzzles/logic/and_selected.png"),
	preload("res://assets/puzzles/logic/or_selected.png"),
	preload("res://assets/puzzles/logic/xor_selected.png"),
]

var current_gate: String = ""
var slot_buttons: Dictionary = {}
var slot_labels: Dictionary = {}

const ON_COLOR = Color("#304E7E")
const OFF_COLOR = Color("#A29DB3")


func _ready():
	_setup_slot_buttons()
	win_message.visible = false

	if Globals.puzzle_phase == 0:
		update_puzzle1_lines()
	elif Globals.puzzle_phase == 1:
		update_puzzle2_lines()
	else:
		update_puzzle3_lines()
	
func _process(_delta):
	if Globals.puzzle_phase == 0:
		$Puzzle1.visible = true
		$Puzzle2.visible = false
		$Puzzle3.visible = false
	elif Globals.puzzle_phase == 1:
		$Puzzle1.visible = false
		$Puzzle2.visible = true
		$Puzzle3.visible = false
	else:
		$Puzzle1.visible = false
		$Puzzle2.visible = false
		$Puzzle3.visible = true
		
	if current_gate == "and":
		and_button.disabled = true
		or_button.disabled = false
		xor_button.disabled = false
	elif current_gate == "or":
		and_button.disabled = false
		or_button.disabled = true
		xor_button.disabled = false
	elif current_gate == "xor":
		and_button.disabled = false
		or_button.disabled = false
		xor_button.disabled = true
	elif current_gate == "not":
		and_button.disabled = false
		or_button.disabled = false
		xor_button.disabled = false
		

func _setup_slot_buttons() -> void:
	for phase in range(3):
		var puzzle_node = get_node("Puzzle%d" % (phase + 1))
		slot_buttons[phase] = {}
		slot_labels[phase] = {}
		
		var slot_count = 3
		if phase == 2:
			slot_count = 4
		for slot in range(1, slot_count + 1):
			var candidates = [
				"gate%d_button" % slot
			]
			
			var button = null
			for candidate in candidates:
				button = puzzle_node.find_child(candidate, true, false)
			slot_buttons[phase][slot] = button
	
func set_line_state(line_name: String, value: int) -> void:
	var line
	if Globals.puzzle_phase == 0:
		line = $Puzzle1.get_node_or_null(line_name)
	elif Globals.puzzle_phase == 1:
		line = $Puzzle2.get_node_or_null(line_name)
	elif Globals.puzzle_phase == 2:
		line = $Puzzle3.get_node_or_null(line_name)
	line.default_color = ON_COLOR if value == 1 else OFF_COLOR
	
func update_puzzle1_lines() -> void:
	var selected: Dictionary = gate_selections[0]
	var input1 = 1
	var input2 = 0
	var input3 = 1
	var input4 = 0
	var input5 = 1
	var input6 = 0
	set_line_state("input1", input1)
	set_line_state("input2", input2)
	set_line_state("input3", input3)
	set_line_state("input4", input4)
	set_line_state("input5", input5)
	set_line_state("input6", input6)
	var g1 = 0
	if selected[1] != "":
		g1 = evaluate_gate(selected[1], input1, input2)
	set_line_state("gate1_and1", g1)
	var g2 = 0
	if selected[2] != "":
		g2 = evaluate_gate(selected[2], input3, input4)
	set_line_state("gate2_not", g2)
	var not_g2 = 1 - g2
	set_line_state("not_and1", not_g2)
	var and1 = int(g1 == 1 and not_g2 == 1)
	set_line_state("and1_and2", and1)
	var g3 = 0
	if selected[3] != "":
		g3 = evaluate_gate(selected[3], input5, input6)
	set_line_state("gate3_and2", g3)
	var final_output = int(and1 == 1 and g3 == 1)
	set_line_state("output", final_output)
	
func update_puzzle2_lines() -> void:
	var selected: Dictionary = gate_selections[1]
	var input1 = 1
	var input2 = 1
	var input3 = 1
	var input4 = 1
	var input5 = 1
	var input6 = 0
	set_line_state("input1", input1)
	set_line_state("input2", input2)
	set_line_state("input3", input3)
	set_line_state("input4", input4)
	set_line_state("input5", input5)
	set_line_state("input6", input6)
	var g1 = 0
	if selected[1] != "":
		g1 = evaluate_gate(selected[1], input1, input2)
	set_line_state("gate1_xor1", g1)
	var g2 = 0
	if selected[2] != "":
		g2 = evaluate_gate(selected[2], input3, input4)
	set_line_state("gate2_not", g2)
	var not_g2 = 1 - g2
	set_line_state("not_xor1", not_g2)
	var xor1 = int(g1 != not_g2)
	set_line_state("xor1_and1", xor1)
	var g3 = 0
	if selected[3] != "":
		g3 = evaluate_gate(selected[3], input5, input6)
	set_line_state("gate3_and1", g3)
	var final_output = int(xor1 == 1 and g3 == 1)
	set_line_state("output", final_output)

func update_puzzle3_lines() -> void:
	var selected: Dictionary = gate_selections[2]
	var input1 = 1
	var input2 = 1
	var input3 = 1
	var input4 = 1
	var input5 = 1
	var input6 = 0
	var input7 = 1
	var input8 = 0
	set_line_state("input1", input1)
	set_line_state("input2", input2)
	set_line_state("input3", input3)
	set_line_state("input4", input4)
	set_line_state("input5", input5)
	set_line_state("input6", input6)
	set_line_state("input7", input7)
	set_line_state("input8", input8)
	var g1 = 0
	if selected[1] != "":
		g1 = evaluate_gate(selected[1], input1, input2)
	set_line_state("gate1_xor1", g1)
	var g2 = 0
	if selected[2] != "":
		g2 = evaluate_gate(selected[2], input3, input4)
	set_line_state("gate2_xor1", g2)
	var xor1 = int(g1 != g2)
	set_line_state("xor1_and2", xor1)
	var g3 = 0
	if selected[3] != "":
		g3 = evaluate_gate(selected[3], input5, input6)
	set_line_state("gate3_and1", g3)
	var g4 = 0
	if selected[4] != "":
		g4 = evaluate_gate(selected[4], input7, input8)
	set_line_state("gate4_and1", g4)
	var and1 = int(g3 == 1 and g4 == 1)
	set_line_state("and1_and2", and1)
	var final_output = int(xor1 == 1 and and1 == 1)
	set_line_state("output", final_output)

func update_gate_texture(button: TextureButton, gate: String) -> void:
	var gate_index = GATE_NAMES.find(gate)
	button.texture_normal = normal_textures[gate_index]
	button.texture_hover = hover_textures[gate_index]
	button.texture_focused = focus_textures[gate_index]
	if Globals.puzzle_phase == 0:
		update_puzzle1_lines()
	elif Globals.puzzle_phase == 1:
		update_puzzle2_lines()
	else:
		update_puzzle3_lines()


func _on_gate_slot_pressed(slot: int) -> void:
	Click.play()
	if current_gate == "":
		return
	
	var phase = Globals.puzzle_phase
	gate_selections[phase][slot] = current_gate
	var button: TextureButton = slot_buttons[phase][slot]
	update_gate_texture(button, current_gate)
	
	current_gate = ""
	and_button.disabled = false
	or_button.disabled = false
	xor_button.disabled = false
	
	
func evaluate_gate(gate: String, a: int, b: int) -> int:
	match gate:
		"and":
			return int(a == 1 and b == 1)
		"or":
			return int(a == 1 or b == 1)
		"xor":
			return int(a != b)
		_:
			return -1

func check_solution() -> bool:
	var phase = Globals.puzzle_phase
	var selected: Dictionary = gate_selections[phase]
	
	for slot in selected:
		if selected[slot] == "":
			return false
			
	var output: int = 0
	
	if phase == 0:
		# Puzzle 1:
		# G1(1,0) AND NOT(G2(1,0)), then AND with G3(1,0).
		var g1 = evaluate_gate(selected[1], 1, 0)
		var g2 = evaluate_gate(selected[2], 1, 0)
		var g3 = evaluate_gate(selected[3], 1, 0)
		
		var not_g2 = int(g2 == 0)
		var middle = int(g1 == 1 and not_g2 == 1)
		output = int(g3 == 1 and middle == 1)
		
	elif phase == 1:
		# Puzzle 2:
		# XOR(G1(1,1), NOT(G2(1,1))), then AND with G3(1,0).
		var g1 = evaluate_gate(selected[1], 1, 1)
		var g2 = evaluate_gate(selected[2], 1, 1)
		var g3 = evaluate_gate(selected[3], 1, 0)
		
		var not_g2 = int(g2 == 0)
		var middle = int(g1 != not_g2)
		output = int(middle == 1 and g3 == 1)
	
	elif phase == 2:
		# Puzzle 3:
		# XOR(G1(1,1), G2(1,1)) AND
		# AND(G3(1,0), G4(1,0)).
		var g1 = evaluate_gate(selected[1], 1, 1)
		var g2 = evaluate_gate(selected[2], 1, 1)
		var g3 = evaluate_gate(selected[3], 1, 0)
		var g4 = evaluate_gate(selected[4], 1, 0)
		
		var upper = int(g1 != g2)
		var lower = int(g3 == 1 and g4 == 1)
		output = int(upper == 1 and lower == 1)
		
	if output == TARGET_OUTPUT:
		return true
	
	return false


func _on_reset_pressed() -> void:
	Click.play()
	get_tree().reload_current_scene()


func _on_check_pressed() -> void:
	Click.play()
	var solution = check_solution()
	if solution == true:
		win_message.visible = true
		$Success.play()
		Globals.puzzle_step = 2
	else:
		win_message.visible = false
		Incorrect.play()
		


func _on_next_pressed() -> void:
	Click.play()
	#Go to workshop
	#Reset puzzle to network
	Globals.puzzle_step = 2
	Globals.in_computer = false
	Globals.can_move = true
	Globals.can_talk = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	if Globals.phase < 3:
		Globals.current_puzzle = "network"
	else:
		Globals.current_puzzle = "password"
		
func _on_and_button_pressed() -> void:
	Click.play()
	current_gate = "and"

func _on_or_button_pressed() -> void:
	Click.play()
	current_gate = "or"

func _on_xor_button_pressed() -> void:
	Click.play()
	current_gate = "xor"

func _on_gate_1_button_pressed() -> void:
	_on_gate_slot_pressed(1)

func _on_gate_2_button_pressed() -> void:
	_on_gate_slot_pressed(2)

func _on_gate_3_button_pressed() -> void:
	_on_gate_slot_pressed(3)
	
func _on_gate_4_button_pressed() -> void:
	_on_gate_slot_pressed(4)

func _on_next_mouse_entered() -> void:
	Hover.play()

func _on_reset_mouse_entered() -> void:
	Hover.play()

func _on_check_mouse_entered() -> void:
	Hover.play()
