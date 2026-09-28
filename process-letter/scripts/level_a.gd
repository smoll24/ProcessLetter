extends Node2D

@onready var outer = $OuterLayer
@onready var inner = $InnerLayer


func _process(delta):
	if Globals.in_room:
		outer.visible = false
		inner.visible = true
	else:
		outer.visible = true
		inner.visible = false
		
