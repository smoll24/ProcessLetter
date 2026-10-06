extends Node2D

@onready var outer = $OuterLayer
@onready var inner = $InnerLayer

@onready var elevator_block = $Collisions/Elevator_Block/CollisionShape2D


func _ready():
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
	elif Globals.outside:
		outer.visible = false
		inner.visible = false
	else:
		outer.visible = true
		inner.visible = false
		


func _on_cutscene_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if Globals.status == "pre1":
			Globals.status = "prog1"
			Globals.puzzle_step = 1
			print("prog1")


func _on_cutscene_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass


func _on_cutscene_5_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass


func _on_cutscene_6_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass


func _on_cutscene_8_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass
