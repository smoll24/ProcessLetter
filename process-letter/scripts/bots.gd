extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

@onready var interact_indicator = $Indicator


var is_wandering = false
var wander_direction = Vector2.ZERO
var wander_steps = 0
var wander_speed = 100.0
var step_distance = 40.0
var wander_timer: Timer
@onready var footstep_audio = $Walking

func _ready():
	update_idle_animation()
	wander_timer = Timer.new()
	wander_timer.one_shot = true
	add_child(wander_timer)
	wander_timer.timeout.connect(_on_wander_timer_timeout)
	wander_timer.start(randf_range(2.0, 3.0))
	
	if Globals.phase == 1:
		sprite.play('1_front_idle')
	elif Globals.phase == 2:
		sprite.play('2_front_idle')
	elif Globals.phase == 3:
		sprite.play('3_front_idle')
	Globals.bot = false

func _process(_delta):
	if Globals.status == "post4":
		self.queue_free()
	
	z_index = int(round(global_position.y / 500.0))
	if Globals.phase == 0:
		self.visible = false
		$CollisionShape2D.disabled = true
	else:
		self.visible = true
		$CollisionShape2D.disabled = false
	
	if Globals.bot and Globals.status == "prog4" and Globals.can_capture:
		interact_indicator.visible = true
	else:
		interact_indicator.visible = false
	
	if is_wandering:
		velocity = wander_direction * wander_speed
		move_and_slide()
		
		if get_slide_collision_count() > 0:
			stop_wandering()
	else:
		velocity = Vector2.ZERO
	
	if Globals.bot and Globals.status == "prog4":
		if Input.is_action_just_pressed("ui_accept") \
		and interact_indicator.visible:
			if Globals.can_capture:
				Incorrect.play()
				Globals.captured += 1
				print("captured: ",Globals.captured)
				if Globals.current_bot_instance == self:
					Globals.current_bot_instance.queue_free()
					Globals.current_bot_instance = null
					Globals.bot = false
	

func _on_wander_timer_timeout() -> void:
	if not Globals.can_move:
		wander_timer.start(randf_range(0.0, 2.0))
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
	wander_steps = randi_range(2, 6)
	
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
	
	# Wait before wandering again
	wander_timer.start(randf_range(0.0, 2.0))


func update_walk_animation() -> void:
	var phase = str(Globals.phase)
	if phase != "0":
	
		if wander_direction == Vector2.UP:
			sprite.flip_h = false
			sprite.play(phase + "_back")
			
		elif wander_direction == Vector2.DOWN:
			sprite.flip_h = false
			sprite.play(phase + "_front_idle")
			
		elif wander_direction == Vector2.LEFT:
			sprite.flip_h = true
			sprite.play(phase + "_side")
			
		elif wander_direction == Vector2.RIGHT:
			sprite.flip_h = false
			sprite.play(phase + "_side")


func update_idle_animation() -> void:
	var phase = str(Globals.phase)
	if phase != "0":
	
		if wander_direction == Vector2.UP:
			sprite.flip_h = false
			sprite.play(phase + "_back")
			
		elif wander_direction == Vector2.DOWN:
			sprite.flip_h = false
			sprite.play(phase + "_front_idle")
			
		elif wander_direction == Vector2.LEFT \
		or wander_direction == Vector2.RIGHT:
			sprite.play(phase + "_side")
	

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.current_bot_instance = self
		Globals.bot = true
		

func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		Globals.bot = false
