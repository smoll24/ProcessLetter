extends AudioStreamPlayer2D

@export var step_delay: float = 0.40
@export var pitch_randomness: float = 0.1

var time_since_last_step: float = 0.0
var is_walking: bool = false

func _process(delta: float) -> void:
	if is_walking:
		print("walking")
		time_since_last_step += delta
		if time_since_last_step >= step_delay and not self.playing:
			print("play")
			play_footstep()
			#self.play()
			time_since_last_step = 0.0 
	else:
		time_since_last_step = step_delay 

func play_footstep() -> void:
	pitch_scale = randf_range(1.0 - pitch_randomness, 1.0 + pitch_randomness)
	self.play()

func start_walking() -> void:
	is_walking = true

func stop_walking() -> void:
	is_walking = false
