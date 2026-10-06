extends Node2D

@onready var outer = $OuterLayer
@onready var inner = $InnerLayer


func _ready():
	Globals.current_level = 1
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	Globals.in_elevator = false
	$level1Outer.visible = true

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
		


func _on_cutscene_4_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if Globals.status == "pre2":
			Globals.status = "prog2"
			Globals.puzzle_step = 1
			print("prog2")
