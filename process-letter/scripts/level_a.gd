extends Node2D

@onready var top = $Alevel_top
@onready var level = $Alevel


func _process(delta):
	if Globals.in_room:
		top.visible = false
		level.visible = false
	else:
		top.visible = true
		level.visible = true
		
