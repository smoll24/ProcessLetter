extends CharacterBody2D

var dialog = null
@onready var interact_indicator = $Indicator

func _ready() -> void:
	Globals.pink = false

func _process(_delta):
	if Globals.status in Globals.interactions["pink"] \
	and Globals.can_talk and Globals.pink:
		interact_indicator.visible = true
	else:
		interact_indicator.visible = false
	
	if Globals.pink:
		if Input.is_action_just_pressed("ui_accept") \
		and interact_indicator.visible:
			Globals.can_move = false
			Globals.can_talk = false
			dialog = Dialogic.start("pink_idle")
			get_tree().root.add_child(dialog)
			Dialogic.timeline_ended.connect(dialog_end)
		
func dialog_end():
	await get_tree().create_timer(0.5).timeout
	Globals.can_talk = true
	Globals.can_move = true


func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.pink = true
	
func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.pink = false
