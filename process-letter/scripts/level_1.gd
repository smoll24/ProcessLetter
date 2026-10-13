extends Node2D

@onready var outer = $OuterLayer
@onready var inner = $InnerLayer


func _ready():
	LevelABg.stop()
	Office.play()
	Level1Bg.play()
	Level3Bg.stop()
	OutsideBg.play()
	OutsideBg.stream_paused = true
	MenuBg.stop()
	
	Globals.current_level = 1
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	Globals.in_elevator = false
	$level1Outer.visible = true

func _process(delta):
	if Globals.in_room:
		outer.visible = false
		inner.visible = true
		Level1Bg.volume_db = -10
	elif Globals.outside:
		outer.visible = false
		inner.visible = false
		Level1Bg.stream_paused = true
		OutsideBg.stream_paused = false
		Level1Bg.volume_db = 0.0
	else:
		outer.visible = true
		inner.visible = false
		Level1Bg.stream_paused = false
		OutsideBg.stream_paused = true
		Level1Bg.volume_db = 0.0
		


func _on_cutscene_4_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if Globals.status == "pre2":
			Globals.status = "prog2"
			Globals.puzzle_step = 1
			print("prog2")
