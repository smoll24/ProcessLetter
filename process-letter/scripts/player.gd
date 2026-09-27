extends CharacterBody2D

const speed = 400
var current_dir = 'none'
var dialog = null
var can_talk = true

func _ready():
	$AnimatedSprite2D.play('front_idle')
	Globals.can_move = true
	Globals.can_talk = true
	
func _physics_process(delta):
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
	var dir = current_dir
	var anim = $AnimatedSprite2D
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
				

#func _on_icon_body_entered(_body: Node2D) -> void:
	#if can_talk:
		#can_talk = false
		#Globals.can_move = false
		#play_anim(0)
		#dialog = Dialogic.start("purple_idle")
		#get_tree().root.add_child(dialog)
		#Dialogic.timeline_ended.connect(dialog_end)
		#
#func dialog_end():
	#await get_tree().create_timer(0.5).timeout
	#can_talk = true
	#Globals.can_move = true
