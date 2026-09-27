extends CharacterBody2D

var dialog = null
@onready var interact_indicator = $Indicator

func _ready() -> void:
	Globals.purple = false

func _process(_delta):
	interact_indicator.visible = Globals.purple
	
	if Globals.purple:
		if Input.is_action_just_pressed("ui_accept") and Globals.can_talk:
			Globals.can_move = false
			Globals.can_talk = false
			dialog = Dialogic.start("purple_idle")
			get_tree().root.add_child(dialog)
			Dialogic.timeline_ended.connect(dialog_end)
		
func dialog_end():
	await get_tree().create_timer(0.5).timeout
	Globals.can_talk = true
	Globals.can_move = true


func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.purple = true
	
func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.purple = false
