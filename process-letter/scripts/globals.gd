extends Node


var can_move = true
var can_talk = true
var puzzle_phase = 0
var status = "pre1"


var purple = false
var pink = false
var teal = false
var blue = false
var violet = false


func _process(delta):
	Dialogic.VAR.set_variable("State", status)
