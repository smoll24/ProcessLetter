extends Node2D

@onready var outer = $OuterLayer
@onready var inner = $InnerLayer


func _ready():
	LevelABg.stop()
	Office.play()
	Level1Bg.stop()
	Level3Bg.play()
	OutsideBg.stop()
	MenuBg.stop()
	
	
	Globals.current_level = 3
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	Globals.in_elevator = false

func _process(delta):
	if Globals.in_room:
		outer.visible = false
		inner.visible = true
		Level3Bg.volume_db = -15
	elif Globals.outside:
		outer.visible = false
		inner.visible = false
		Level3Bg.volume_db = 0.0
	else:
		outer.visible = true
		inner.visible = false
		Level3Bg.volume_db = 0.0
		


func _on_cutscene_7_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if Globals.status == "pre3":
			Globals.status = "prog3"
			Globals.puzzle_step = 1
			print("prog3")
