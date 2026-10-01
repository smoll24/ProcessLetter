extends Node

enum Enter {START, STAIR_TOP, STAIR_BOTTOM, ELEVATOR}

var can_move = true
var can_talk = true
var puzzle_phase = 0
var status = "prog3"
var phase = 3
var in_room = true

var entrance: Enter = Enter.START

var interactions = {"purple":["prog3","pre1","prog1","pre2","prog2","pre3"],
"pink":["prog3","pre3"], "blue":["prog3","prog2","pre3"],
"teal":["prog3","pre1","prog1","pre2","prog2","pre3"],
"violet":["prog3","pre1","prog1","pre2","prog2","pre3"],
"workbench":["prog1","prog2","prog3"],
"computer":["prog1","prog2","prog3"]}

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

var can_capture = true
var captured = 0

var book = false
var book_type = 0
var in_book = false

var current_bot_instance: CharacterBody2D = null

func _process(delta):
	Dialogic.VAR.set_variable("State", status)
	
	if paused:
		can_move = false
		can_talk = false
