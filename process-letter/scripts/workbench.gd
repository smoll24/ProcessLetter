extends Node2D

@onready var interact_indicator = $Indicator2
@onready var indicator2 = $Indicator_bubble
@export var type : int

func _ready() -> void:
	Globals.workbench = false

func _process(_delta):
	var show_interact_indicator := false
	var show_indicator2 := false

	# Computer
	if type == 0 and Globals.puzzle_step == 1:
		if Globals.status in Globals.interactions["computer"] \
		and Globals.can_talk:
			show_indicator2 = true
			if Globals.workbench \
			and Globals.workbench_type == type:
				show_interact_indicator = true

	# Workbench
	elif type == 1 and Globals.puzzle_step == 2:
		if Globals.status in Globals.interactions["workbench"] \
		and Globals.can_talk:
			show_indicator2 = true
			if Globals.workbench \
			and Globals.workbench_type == type:
				show_interact_indicator = true

	interact_indicator.visible = show_interact_indicator
	indicator2.visible = show_indicator2
	
	if interact_indicator.visible:
		indicator2.visible = false
	
	if Globals.workbench:
		if Input.is_action_just_pressed("ui_accept") \
		and interact_indicator.visible:
			Hover.play()
			Globals.can_move = false
			Globals.can_talk = false
			if type == 0:
				Globals.in_computer = true
			elif type == 1:
				Globals.in_workbench = true

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.workbench = true
		Globals.workbench_type = self.type
	
func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.workbench = false
