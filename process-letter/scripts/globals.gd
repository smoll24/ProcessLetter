extends Node


var can_move = true
var can_talk = true
var puzzle_phase = 0
var status = "prog3"

var interactions = {"purple":["prog3","pre1","prog1","pre2","prog2","pre3"],
"pink":["prog3","pre3"], "blue":["prog3","prog2","pre3"],
"teal":["prog3","pre1","prog1","pre2","prog2","pre3"],
"violet":["prog3","pre1","prog1","pre2","prog2","pre3"]}

var purple = false
var pink = false
var teal = false
var blue = false
var violet = false


func _process(delta):
	Dialogic.VAR.set_variable("State", status)
