extends Node2D

@onready var outer = $OuterLayer
@onready var inner = $InnerLayer

@onready var elevator_block = $Collisions/Elevator_Block/CollisionShape2D


func _ready():
	if Globals.status == "pre1":
		Globals.current_cutscene = 1
		Globals.in_cutscene = true
	
	LevelABg.play()
	Office.play()
	Level1Bg.stop()
	Level3Bg.stop()
	OutsideBg.stop()
	MenuBg.stop()
	WorkshopBg.play()
	WorkshopBg.stream_paused = true
	
	Globals.current_level = 0
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	Globals.in_elevator = false

func _process(_delta):
	if Globals.phase == 0:
		elevator_block.disabled = false
	else:
		elevator_block.disabled = true
	
	if Globals.in_room:
		outer.visible = false
		inner.visible = true
		LevelABg.volume_db = -10
	elif Globals.outside:
		outer.visible = false
		inner.visible = false
		LevelABg.volume_db = 0
	else:
		outer.visible = true
		inner.visible = false
		LevelABg.volume_db = 0
		


func _on_cutscene_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and Globals.status == "pre1":
		Globals.current_cutscene = 2
		Globals.in_cutscene = true
		
		if Globals.status == "pre1":
			Globals.puzzle_step = 1
			print("prog1")
			Globals.status = "prog1"


func _on_cutscene_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and Globals.status == "pre2":
		Globals.current_cutscene = 3
		Globals.in_cutscene = true


func _on_cutscene_5_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and Globals.status == "pre3":
		Globals.current_cutscene = 5
		Globals.in_cutscene = true


func _on_cutscene_6_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and Globals.status == "pre3":
		Globals.current_cutscene = 6
		Globals.in_cutscene = true


func _on_cutscene_8_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and Globals.status == "prog3":
		Globals.current_cutscene = 8
		Globals.in_cutscene = true
