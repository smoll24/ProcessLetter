extends Node


var can_move = true
var puzzle_phase = 0
var status = "pre1"


func _process(delta):
	Dialogic.VAR.set_variable("State", status)
