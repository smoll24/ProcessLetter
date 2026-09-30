extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

@onready var interact_indicator = $Indicator

func _ready():
	if Globals.phase == 1:
		sprite.play('1_front_idle')
	elif Globals.phase == 2:
		sprite.play('2_front_idle')
	elif Globals.phase == 3:
		sprite.play('3_front_idle')
	Globals.bot = false

func _process(_delta):
	if Globals.bot:
		interact_indicator.visible = true
	else:
		interact_indicator.visible = false
		
	
	if Globals.bot:
		if Input.is_action_just_pressed("ui_accept") \
		and interact_indicator.visible:
			if Globals.can_capture:
				Globals.captured += 1
				if Globals.current_bot_instance == self:
					Globals.current_bot_instance.queue_free()
					Globals.current_bot_instance = null
					Globals.bot = false
	

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.current_bot_instance = self
		Globals.bot = true
		

func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.bot = false
