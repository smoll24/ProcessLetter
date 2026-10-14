extends Control

@onready var win_message = $Win

@onready var and_button = $Buttons/HBoxContainer/and_button
@onready var or_button = $Buttons/HBoxContainer/or_button
@onready var xor_button = $Buttons/HBoxContainer/xor_button
@onready var not_button = $Buttons/HBoxContainer/not_button

const TARGET_OUTPUT = 1
const GATE_NAMES = ["and", "or", "xor", "not"]

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

var current_gate: String = ""
var slot_buttons: Dictionary = {}
var slot_labels: Dictionary = {}


func _ready():
	_setup_slot_buttons()
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
		

func _setup_slot_buttons() -> void:
	for phase in range(3):
		var puzzle_node = get_node("Puzzle%d" % (phase + 1))
		slot_buttons[phase] = {}
		slot_labels[phase] = {}
		
		var slot_count = 3
		if phase == 4:
			slot_count = 3
		for slot in range(1, slot_count + 1):
			var candidates = [
				"gate%d_button" % slot
			]
			
			var button = null
			for candidate in candidates:
				button = puzzle_node.find_child(candidate, true, false)
			slot_buttons[phase][slot] = button
	

func _on_gate_slot_pressed(slot: int) -> void:
	Click.play()
	if current_gate == "":
		return
	
	var phase = Globals.puzzle_phase
	gate_selections[phase][slot] = current_gate
	
	current_gate = ""
	
	
func evaluate_gate(gate: String, a: int, b: int) -> int:
	match gate:
		"and":
			return int(a == 1 and b == 1)
		"or":
			return int(a == 1 or b == 1)
		"xor":
			return int(a != b)
		"not":
			return int(a == 0)
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
		Correct.play()
	else:
		win_message.visible = false
		Incorrect.play()
		


func _on_next_pressed() -> void:
	Click.play()
	#Go to workshop
	#Reset puzzle to network
	Globals.puzzle_step = 2
	Globals.current_puzzle = "network"


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
