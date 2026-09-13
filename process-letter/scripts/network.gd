extends Node2D

@onready var button1 = $Button1
@onready var button2 = $Button2
@onready var button3 = $Button3
@onready var button4 = $Button4
@onready var button5 = $Button5
@onready var button6 = $Button6
@onready var button7 = $Button7
@onready var button8 = $Button8
@onready var button9 = $Button9
@onready var button10 = $Button10
@onready var button11 = $Button11

@onready var label = $Label

var buttons = []
var connections = []
var filled_connections = []
var selected_point = -1

func _ready():
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
				
	init_game()
	
	
func _process(delta):
	pass
	
func _setup_game(phase):
	if phase == 0:
		connections = [[1,2],
					[2,7],
					[7,11],
					[1,3],
					[3,4],
					[4,5],
					[5,6],
					[6,7],
					[1,5],
					[2,5],
					[1,4],
					[2,6],
					[3,9],
					[9,10],
					[8,9],
					[3,8],
					[6,11],
					[8,10],
					[8,4]]

func _create_connections(buttons: Array, connections: Array):
	for connection in connections:
		var point_a = connection[0]
		var point_b = connection[1]
		
		var button_a = buttons[point_a - 1]
		var button_b = buttons[point_b - 1]
		
		var line = Line2D.new()
		line.name = "Line_%d_%d" % [point_a, point_b]
		line.width = 5.0
		line.default_color = Color("#ffffff")
		line.z_index = -1
		
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
	_create_connections(buttons, connections)
	

func fill_connection(point_a: int, point_b: int):
	for connection in filled_connections:
		var points = connection["points"]
		
		if (points[0] == point_a and points[1] == point_b) \
		or (points[0] == point_b and points[1] == point_a):
			
			if connection["filled"]:
				return
			
			connection["filled"] = true
			connection["line"].default_color = Color("#272727")
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
	get_tree().reload_current_scene()

func _on_check_pressed() -> void:
	var solution = check_solution()
	label.text = solution[1]
