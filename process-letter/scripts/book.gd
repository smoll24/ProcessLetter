extends Node2D

@onready var interact_indicator = $Indicator
@onready var indicator_bubble = $Indicator_bubble
@export var type : int

func _ready() -> void:
	Globals.book = false

func _process(_delta):
	if Globals.book and Globals.book_type == self.type:
		indicator_bubble.visible = false
		interact_indicator.visible = true
	else:
		indicator_bubble.visible = true
		interact_indicator.visible = false
		
	
	if Globals.book:
		if Input.is_action_just_pressed("ui_accept") \
		and interact_indicator.visible:
			Hover.play()
			Globals.can_move = false
			Globals.can_talk = false
			Globals.in_book = true


func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.book = true
		Globals.book_type = self.type
		print(Globals.book_type)
	
func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.book = false
