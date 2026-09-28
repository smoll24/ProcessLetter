extends Node2D

@onready var interact_indicator = $Indicator
@onready var indicator2 = $Indicator2

func _ready() -> void:
	Globals.workbench = false

func _process(_delta):
	if Globals.status in Globals.interactions["workbench"] \
	and Globals.can_talk and Globals.workbench:
		interact_indicator.visible = true
	else:
		interact_indicator.visible = false
	
	if Globals.status in Globals.interactions["workbench"] \
	and Globals.can_talk:
		indicator2.visible = true
	else:
		indicator2.visible = false
	
	if Globals.workbench:
		if Input.is_action_just_pressed("ui_accept") \
		and interact_indicator.visible:
			Globals.can_move = false
			Globals.can_talk = false
			Globals.in_workbench = true
		
#func dialog_end():
	#await get_tree().create_timer(0.5).timeout
	#Globals.can_talk = true
	#Globals.can_move = true

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.workbench = true
	
func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.workbench = false
