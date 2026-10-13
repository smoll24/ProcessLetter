extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var footstep_audio = $Walking

const speed = 500
var current_dir = 'none'
var dialog = null
var can_talk = true

func _ready():
	if Globals.phase == 0:
		self.global_position = Vector2(106.0, 483.0)
	if Globals.reloading:
		self.global_position = Globals.stored_player_position
		Globals.reloading = false
	anim.play('front_idle')
	Globals.can_move = true
	Globals.can_talk = true
	
func _physics_process(delta):
	z_index = int(round(global_position.y / 500.0))
	Globals.player_position = global_position
	if Globals.can_move:
		player_movement(delta)
	else:
		play_anim(0)
	
func player_movement(_delta):
	if Input.is_action_pressed('ui_right'):
		current_dir = 'right'
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed('ui_left'):
		current_dir = 'left'
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed('ui_down'):
		current_dir = 'down'
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed('ui_up'):
		current_dir = 'up'
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	move_and_slide()
	
func play_anim(movement):
	if movement == 1:
		footstep_audio.start_walking()
	else:
		footstep_audio.stop_walking()
		
	var dir = current_dir
	if dir == 'right':
		anim.flip_h = false
		if movement == 1:
			anim.play('side_walk')
		elif movement == 0:
			anim.play('side_idle')
	if dir == 'left':
			anim.flip_h = true
			if movement == 1:
				anim.play('side_walk')
			elif movement == 0:
				anim.play('side_idle')
	if dir == 'down':
			anim.flip_h = false
			if movement == 1:
				anim.play('front_walk')
			elif movement == 0:
				anim.play('front_idle')
	if dir == 'up':
			anim.flip_h = true
			if movement == 1:
				anim.play('back_walk')
			elif movement == 0:
				anim.play('back_idle')
			
func _on_area_2d_body_entered(body: Node2D, out: bool) -> void:
	if body.is_in_group("player"): 
		if out:
			Globals.outside = true
		else:
			Globals.in_room = true

func _on_area_2d_body_exited(body: Node2D, out: bool) -> void:
	if body.is_in_group("player"): 
		if out:
			Globals.outside = false
		else:
			Globals.in_room = false
