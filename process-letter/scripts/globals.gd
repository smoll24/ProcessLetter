extends Node

var can_move = true
var can_talk = true
#0,1,2,3
var puzzle_phase = 0
var status = "pre1"
#1,2,3
var phase:int
var in_room = true

var interactions = {"purple":["post3"], "pink":["post3"],"blue":["post3"],
"teal":[],"violet":["post3"], "workbench":["prog1","prog2","prog3"],
"computer":["prog1","prog2","prog3"]}

#var interactions = {"purple":["prog3","pre1","prog1","pre2","prog2","pre3"],
#"pink":["prog3","pre3"], "blue":["prog3","prog2","pre3"],
#"teal":["prog3","pre1","prog1","pre2","prog2","pre3"],
#"violet":["prog3","pre1","prog1","pre2","prog2","pre3"],
#"workbench":["prog1","prog2","prog3"],
#"computer":["prog1","prog2","prog3"]}

var current_level = 0

var purple = false
var pink = false
var teal = false
var blue = false
var violet = false
var workbench = false
var workbench_type = 0
var in_workbench = false
var in_computer = false
var elevator = false
var in_elevator = false
var bot = false
var paused = false
var outside = false

var can_capture = false
var captured = 0

var book = false
var book_type = 1
var in_book = false

var in_cutscene = false

var blue_convo = false
var purple_convo = false
var violet_convo = false
var pink_convo = false

var current_cutscene = 0

#Indicates whether you can enter 1. Computer 2. Workshop 
var puzzle_step = 1
#Network, Sudoku, Logic
var current_puzzle = "network"

var player_position: Vector2
var stored_player_position: Vector2

var current_bot_instance: CharacterBody2D = null

var conversations = 0

var reloading = false

var cutscenes = []

func _process(_delta):
	var puzzle_phase = phase
	
	Dialogic.VAR.set_variable("State", status)
	
	if status == "prog4":
		can_capture = true
	
	if paused:
		can_move = false
		can_talk = false
		
	if status == "pre1" or status == "prog1":
		phase = 0
	if status == "pre2" or status == "prog2":
		phase = 1
	if status == "pre3" or status == "prog3":
		phase = 2
	if status == "post3" or status == "prog4" or status == "post4":
		phase = 3
	if pink_convo and blue_convo and purple_convo \
	and violet_convo and status == "post3":
		status = "prog4"
		print("prog4")
	if captured == 4 and status == "prog4":
		status = "post4"
		print("post4")
