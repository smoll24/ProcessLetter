extends CharacterBody2D

var dialog = null
@onready var interact_indicator = $Indicator
@onready var indicator2 = $Indicator2

func _ready() -> void:
	Globals.violet = false

func _process(_delta):
	if Globals.status in Globals.interactions["violet"] \
	and Globals.can_talk and Globals.violet:
		interact_indicator.visible = true
	else:
		interact_indicator.visible = false
		
	if Globals.status in Globals.interactions["violet"] \
	and Globals.can_talk:
		indicator2.visible = true
	else:
		indicator2.visible = false
	
	if Globals.violet:
		if Input.is_action_just_pressed("ui_accept") \
		and interact_indicator.visible:
			Globals.can_move = false
			Globals.can_talk = false
			dialog = Dialogic.start("violet_idle")
			get_tree().root.add_child(dialog)
			Dialogic.timeline_ended.connect(dialog_end)
		
func dialog_end():
	await get_tree().create_timer(0.5).timeout
	Globals.can_talk = true
	Globals.can_move = true


func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.violet = true
	
func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.violet = false
