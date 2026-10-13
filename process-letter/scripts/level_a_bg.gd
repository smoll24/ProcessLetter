extends AudioStreamPlayer

func _process(delta: float) -> void:
	if Globals.phase == 3 and Globals.status != "post4":
		if stream != preload("res://assets/sounds/nojisuma-something_lost-185380.mp3"):
			stream = preload("res://assets/sounds/nojisuma-something_lost-185380.mp3")
	elif Globals.status == "post4":
		if stream != preload("res://assets/sounds/nojisuma-light_shining_through-193960.mp3"):
			stream = preload("res://assets/sounds/nojisuma-light_shining_through-193960.mp3")
	else:
		if stream != preload("res://assets/sounds/nojisuma-walking_while_looking_at_the_moon-187621.mp3"):
			stream = preload("res://assets/sounds/nojisuma-walking_while_looking_at_the_moon-187621.mp3")
