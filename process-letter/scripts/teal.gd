extends CharacterBody2D

var dialog = null
@onready var interact_indicator = $Indicator
@onready var indicator2 = $Indicator2

func _ready() -> void:
	Globals.teal = false

func _process(_delta):
	if Globals.status in Globals.interactions["teal"] \
	and Globals.can_talk and Globals.teal:
		interact_indicator.visible = true
	else:
		interact_indicator.visible = false
	
	if Globals.status in Globals.interactions["teal"] \
	and Globals.can_talk:
		indicator2.visible = true
	else:
		indicator2.visible = false
	
	if Globals.teal:
		if Input.is_action_just_pressed("ui_accept") \
		and interact_indicator.visible:
			Globals.can_move = false
			Globals.can_talk = false
			dialog = Dialogic.start("teal_idle")
			get_tree().root.add_child(dialog)
			Dialogic.timeline_ended.connect(dialog_end)
		
func dialog_end():
	Globals.can_move = true
	await get_tree().create_timer(0.5).timeout
	Globals.can_talk = true


func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.teal = true
	
func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.teal = false
