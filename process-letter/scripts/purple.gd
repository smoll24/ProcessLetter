extends CharacterBody2D

var dialog = null
@onready var interact_indicator = $Indicator
@onready var indicator2 = $Indicator2
@onready var speech_bubble = $Speech
@onready var speech_text = $Speech/RichTextLabel
var bubble_tween: Tween
var bubble_max_distance = 50

@onready var animated_sprite = $AnimatedSprite2D

var is_wandering = false
var wander_direction = Vector2.ZERO
var wander_steps = 0
var wander_speed = 40.0
var step_distance = 30.0
var wander_timer: Timer


var speech = {
	"pre1":"Worthless piece of junk.",
	"prog1":"I wish I hadn't...",
	"pre2":"...",
	"prog2":"That's not right...",
	"pre3":"That's not good.",
	"prog3":"You can't believe that!"
}

func _ready() -> void:
	Globals.purple = false
	
	wander_timer = Timer.new()
	wander_timer.one_shot = true
	add_child(wander_timer)
	wander_timer.timeout.connect(_on_wander_timer_timeout)
	wander_timer.start(randf_range(2.0, 5.0))
	
	animated_sprite.play("front_idle")

func _process(_delta):
	z_index = int(global_position.y)/100
	speech_bubble.z_index = Globals.player_position.y + 1
	if is_wandering:
		velocity = wander_direction * wander_speed
		move_and_slide()
		if get_slide_collision_count() > 0:
			stop_wandering()
	else:
		velocity = Vector2.ZERO
	
	if Globals.status in speech:
		speech_bubble.visible = true
		speech_text.text = speech[Globals.status]
		update_speech_opacity()
		if not bubble_tween or not bubble_tween.is_valid():
			start_floating_animation()
	else:
		speech_bubble.visible = false
		if bubble_tween and bubble_tween.is_valid():
			bubble_tween.kill()
		speech_bubble.position.y = 0
	
	if Globals.status in speech:
		speech_bubble.visible = true
		speech_text.text = speech[Globals.status]
	else:
		speech_bubble.visible = false
	
	if Globals.status in Globals.interactions["purple"] \
	and Globals.can_talk and Globals.purple:
		interact_indicator.visible = true
	else:
		interact_indicator.visible = false
	
	if Globals.status in Globals.interactions["purple"] \
	and Globals.can_talk:
		indicator2.visible = true
	else:
		indicator2.visible = false
	
	if Globals.purple:
		if Input.is_action_just_pressed("ui_accept") \
		and interact_indicator.visible:
			if is_wandering:
				stop_wandering()
				wander_timer.stop()
			Globals.can_move = false
			Globals.can_talk = false
			dialog = Dialogic.start("purple_idle")
			get_tree().root.add_child(dialog)
			Dialogic.timeline_ended.connect(dialog_end)
		
func dialog_end():
	Globals.can_move = true
	await get_tree().create_timer(0.5).timeout
	Globals.can_talk = true
	wander_timer.start(randf_range(2.0, 5.0))

func start_floating_animation():
	bubble_tween = create_tween().set_loops()
	var start_y = speech_bubble.position.y
	bubble_tween.tween_property(speech_bubble, "position:y", start_y - 10, 1.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	bubble_tween.tween_property(speech_bubble, "position:y", start_y, 1.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func update_speech_opacity():
	var distance = Globals.player_position.distance_to(global_position)
	var opacity = 0.5 * (1.0 - (distance - 50.0) / (400.0 - 50.0))
	var cur_opacity = clamp(opacity, 0.0, 0.5)
	speech_bubble.modulate.a = cur_opacity
	
	
func _on_wander_timer_timeout() -> void:
	#When wander timer runs out
	if not Globals.can_move or not Globals.can_talk:
		wander_timer.start(randf_range(2.0, 5.0))
		return
	
	if is_wandering:
		return
	
	start_wandering()
		
func start_wandering() -> void:
	is_wandering = true
	var directions = [
		Vector2.UP,
		Vector2.DOWN,
		Vector2.LEFT,
		Vector2.RIGHT
	]
	wander_direction = directions.pick_random()
	wander_steps = randi_range(1, 4)
	update_walk_animation()
	await get_tree().create_timer(
		wander_steps * (step_distance / wander_speed)
	).timeout
	if is_wandering:
		stop_wandering()
	
func stop_wandering() -> void:
	is_wandering = false
	velocity = Vector2.ZERO
	update_idle_animation()
	wander_direction = Vector2.ZERO
	#Wait before wandering again
	wander_timer.start(randf_range(3.0, 6.0))
	
func update_walk_animation() -> void:
	if wander_direction == Vector2.UP:
		animated_sprite.flip_h = false
		animated_sprite.play("back_walk")
		
	elif wander_direction == Vector2.DOWN:
		animated_sprite.flip_h = false
		animated_sprite.play("front_walk")
		
	elif wander_direction == Vector2.LEFT:
		animated_sprite.flip_h = true
		animated_sprite.play("side_walk")
		
	elif wander_direction == Vector2.RIGHT:
		animated_sprite.flip_h = false
		animated_sprite.play("side_walk")
		
func update_idle_animation() -> void:
	if wander_direction == Vector2.UP:
		animated_sprite.play("back_idle")
		
	elif wander_direction == Vector2.DOWN:
		animated_sprite.play("front_idle")
		
	elif wander_direction == Vector2.LEFT \
	or wander_direction == Vector2.RIGHT:
		animated_sprite.play("side_idle")
		



func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.purple = true
	
func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.purple = false
