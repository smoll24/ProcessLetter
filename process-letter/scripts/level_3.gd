extends Node2D

@onready var outer = $OuterLayer
@onready var inner = $InnerLayer


func _ready():
	Globals.current_level = 3
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	Globals.in_elevator = false

func _process(delta):
	if Globals.in_room:
		outer.visible = false
		inner.visible = true
	elif Globals.outside:
		outer.visible = false
		inner.visible = false
	else:
		outer.visible = true
		inner.visible = false
		
