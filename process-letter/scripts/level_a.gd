extends Node2D

@onready var level = $Alevel


func _process(delta):
	if Globals.in_room:
		level.visible = false
	else:
		level.visible = true
		
