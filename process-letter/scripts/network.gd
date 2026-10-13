extends Control

var button1
var button2
var button3
var button4
var button5
var button6
var button7
var button8
var button9
var button10
var button11
var button12
var button13
var button14
var button15
var button16
var button17
var button18
var button19
var button20
var button21
var button22
var button23
var button24

@onready var label = $Label
@onready var win_message = $Win

var buttons = []
var connections = []
var filled_connections = []
var selected_point = -1

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
	
func _setup_game(phase):
	if phase == 0:
		connections = [[1,2],
					[2,7], [7,11], [1,3],
					[3,4], [4,5], [5,6],
					[6,7], [1,5], [2,5],
					[1,4], [2,6], [3,9],
					[9,10], [8,9], [3,8],
					[6,11], [8,10], [8,4]]
		button1 = $Puzzle1/Button1
		button2 = $Puzzle1/Button2
		button3 = $Puzzle1/Button3
		button4 = $Puzzle1/Button4
		button5 = $Puzzle1/Button5
		button6 = $Puzzle1/Button6
		button7 = $Puzzle1/Button7
		button8 = $Puzzle1/Button8
		button9 = $Puzzle1/Button9
		button10 = $Puzzle1/Button10
		button11 = $Puzzle1/Button11
		buttons = [button1,
				button2,
				button3,
				button4,
				button5,
				button6,
				button7,
				button8,
				button9,
				button10,
				button11]
	elif phase == 1:
		connections = [[1,5],[1,2],[1,6],
					[2,5],[3,7],[6,11],
					[3,8],[4,5],[4,9],
					[5,9],[5,10],
					[5,11],[6,10],[6,7],
					[7,8],[7,12],[7,11],
					[7,13],[8,13],[8,12],
					[9,10],[9,14],[10,11],
					[10,14],[11,12],[11,15],
					[12,13],[12,16],[12,17],
					[14,15],[15,16],[13,16],
					[14,18],[15,18],[16,17],
					]
		button1 = $Puzzle2/Button1
		button2 = $Puzzle2/Button2
		button3 = $Puzzle2/Button3
		button4 = $Puzzle2/Button4
		button5 = $Puzzle2/Button5
		button6 = $Puzzle2/Button6
		button7 = $Puzzle2/Button7
		button8 = $Puzzle2/Button8
		button9 = $Puzzle2/Button9
		button10 = $Puzzle2/Button10
		button11 = $Puzzle2/Button11
		button12 = $Puzzle2/Button12
		button13 = $Puzzle2/Button13
		button14 = $Puzzle2/Button14
		button15 = $Puzzle2/Button15
		button16 = $Puzzle2/Button16
		button17 = $Puzzle2/Button17
		button18 = $Puzzle2/Button18
		buttons = [button1,
				button2,
				button3,
				button4,
				button5,
				button6,
				button7,
				button8,
				button9,
				button10,
				button11,
				button12,
				button13,
				button14,
				button15,
				button16,
				button17,
				button18]
	elif phase == 2:
		connections = [[1,2],[1,6],[2,3],
					[2,7],[2,8],[3,4],
					[3,8],[4,5],[4,9],
					[4,10],[5,9],
					[6,7],[7,8],[8,9],
					[7,13],[8,13],[8,14],
					[9,13],[9,14],[10,14],
					[10,15],[10,24],[11,24],
					[11,15],[12,13],[13,14],
					[14,15],[15,24],[12,16],
					[13,16],[13,17],[13,18],
					[14,18],[15,18],[15,19],
					[18,19],[19,24],[16,20],
					[16,17],[17,18],[17,21],
					[18,21],[20,21],[21,22],
					[22,23],[19,23]]
		button1 = $Puzzle3/Button1
		button2 = $Puzzle3/Button2
		button3 = $Puzzle3/Button3
		button4 = $Puzzle3/Button4
		button5 = $Puzzle3/Button5
		button6 = $Puzzle3/Button6
		button7 = $Puzzle3/Button7
		button8 = $Puzzle3/Button8
		button9 = $Puzzle3/Button9
		button10 = $Puzzle3/Button10
		button11 = $Puzzle3/Button11
		button12 = $Puzzle3/Button12
		button13 = $Puzzle3/Button13
		button14 = $Puzzle3/Button14
		button15 = $Puzzle3/Button15
		button16 = $Puzzle3/Button16
		button17 = $Puzzle3/Button17
		button18 = $Puzzle3/Button18
		button19 = $Puzzle3/Button19
		button20 = $Puzzle3/Button20
		button21 = $Puzzle3/Button21
		button22 = $Puzzle3/Button22
		button23 = $Puzzle3/Button23
		button24 = $Puzzle3/Button24
		buttons = [button1,
				button2,
				button3,
				button4,
				button5,
				button6,
				button7,
				button8,
				button9,
				button10,
				button11,
				button12,
				button13,
				button14,
				button15,
				button16,
				button17,
				button18,
				button19,
				button20,
				button21,
				button22,
				button23,
				button24]

func _create_connections(connections: Array):
	for connection in connections:
		var point_a = connection[0]
		var point_b = connection[1]
		
		var button_a = buttons[point_a - 1]
		var button_b = buttons[point_b - 1]
		
		var line = Line2D.new()
		line.name = "Line_%d_%d" % [point_a, point_b]
		line.width = 5.0
		line.default_color = Color("#A29DB3")
		line.z_index = 1
		
		line.add_point(button_a.position + button_a.size / 2)
		line.add_point(button_b.position + button_b.size / 2)
		
		add_child(line)
		
		filled_connections.append({
			"points": [point_a, point_b],
			"line": line,
			"filled": false
		})

func init_game():
	_setup_game(Globals.puzzle_phase)
	_create_connections(connections)
	

func fill_connection(point_a: int, point_b: int):
	for connection in filled_connections:
		var points = connection["points"]
		
		if (points[0] == point_a and points[1] == point_b) \
		or (points[0] == point_b and points[1] == point_a):
			
			if connection["filled"]:
				return
			
			connection["filled"] = true
			connection["line"].default_color = Color("#304E7E")
			selected_point = point_b
			buttons[selected_point-1].grab_focus()
			return
		

func are_connected(point_a: int, point_b: int) -> bool:
	for connection in connections:
		if (connection[0] == point_a and connection[1] == point_b) \
		or (connection[0] == point_b and connection[1] == point_a):
			return true
	return false
	
func are_filled(point_a: int, point_b: int) -> bool:
	for connection in filled_connections:
		var points = connection["points"]
		
		if (points[0] == point_a and points[1] == point_b) \
		or (points[0] == point_b and points[1] == point_a):
			
			if connection["filled"] == true:
				return true
	return false
	
func _on_point_pressed(point: int):
	Click.play()
	if selected_point == -1:
		selected_point = point
		buttons[selected_point-1].grab_focus()
		return
	
	if are_connected(selected_point, point) and not are_filled(selected_point, point):
		fill_connection(selected_point, point)
	else:
		print("Points not connected")
	
	buttons[selected_point-1].grab_focus()
	
func check_solution() -> Array:
	for connection in filled_connections:
		if connection["filled"] == false:
			return [false, "Not all connections filled"]
	return [true, "Correct!"]

func _on_button_1_pressed() -> void:
	_on_point_pressed(1)
	
func _on_button_2_pressed() -> void:
	_on_point_pressed(2)

func _on_button_3_pressed() -> void:
	_on_point_pressed(3)

func _on_button_4_pressed() -> void:
	_on_point_pressed(4)
	
func _on_button_5_pressed() -> void:
	_on_point_pressed(5)

func _on_button_6_pressed() -> void:
	_on_point_pressed(6)
	
func _on_button_7_pressed() -> void:
	_on_point_pressed(7)

func _on_button_8_pressed() -> void:
	_on_point_pressed(8)
	
func _on_button_9_pressed() -> void:
	_on_point_pressed(9)
	
func _on_button_10_pressed() -> void:
	_on_point_pressed(10)

func _on_button_11_pressed() -> void:
	_on_point_pressed(11)
	
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


func _on_button_12_pressed() -> void:
	_on_point_pressed(12)

func _on_button_13_pressed() -> void:
	_on_point_pressed(13)

func _on_button_14_pressed() -> void:
	_on_point_pressed(14)

func _on_button_15_pressed() -> void:
	_on_point_pressed(15)

func _on_button_16_pressed() -> void:
	_on_point_pressed(16)

func _on_button_17_pressed() -> void:
	_on_point_pressed(17)

func _on_button_18_pressed() -> void:
	_on_point_pressed(18)

func _on_button_19_pressed() -> void:
	_on_point_pressed(19)

func _on_button_20_pressed() -> void:
	_on_point_pressed(20)

func _on_button_21_pressed() -> void:
	_on_point_pressed(21)

func _on_button_22_pressed() -> void:
	_on_point_pressed(22)

func _on_button_23_pressed() -> void:
	_on_point_pressed(23)

func _on_button_24_pressed() -> void:
	_on_point_pressed(24)


func _on_next_pressed() -> void:
	Click.play()
	#Globals.current_puzzle = "sudoku"
	#Temp to go straight to workshop
	Globals.puzzle_step = 2
