extends Node2D

@onready var interact_indicator = $Indicator
@onready var indicator2 = $Indicator2
@export var type : int

func _ready() -> void:
	Globals.workbench = false

func _process(_delta):
	if type == 0:
		if Globals.status in Globals.interactions["computer"] \
		and Globals.can_talk and Globals.workbench and Globals.workbench_type == self.type:
			interact_indicator.visible = true
		else:
			interact_indicator.visible = false
		
		if Globals.status in Globals.interactions["computer"] \
		and Globals.can_talk:
			indicator2.visible = true
		else:
			indicator2.visible = false
	
	elif type == 1:
		if Globals.status in Globals.interactions["workbench"] \
		and Globals.can_talk and Globals.workbench and Globals.workbench_type == self.type:
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
			if type == 0:
				Globals.in_computer = true
			elif type == 1:
				Globals.in_workbench = true
		
#func dialog_end():
	#await get_tree().create_timer(0.5).timeout
	#Globals.can_talk = true
	#Globals.can_move = true

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.workbench = true
		Globals.workbench_type = self.type
	
func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.workbench = false
