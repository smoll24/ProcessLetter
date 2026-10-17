extends CanvasLayer

@onready var resume_button = $VBoxContainer/Unpause

@onready var options_screen = $OptionsUi


var music: int = AudioServer.get_bus_index("Music")
var sounds: int = AudioServer.get_bus_index("Sounds")

func _ready():
	visible = false
	
func _process(_delta: float) -> void:
	if self.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		AudioServer.set_bus_volume_db(music, Globals.music_volume - 15)
		AudioServer.set_bus_volume_db(sounds, Globals.sounds_volume - 15)
	else: 
		AudioServer.set_bus_volume_db(music, Globals.music_volume)
		AudioServer.set_bus_volume_db(sounds, Globals.sounds_volume)
	
	if Globals.options and options_screen != null:
		options_screen.visible = true
	else:
		options_screen.visible = false
		

func _input(event):
	if event.is_action_pressed("pause"):
		Globals.save_game()
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		Globals.paused = new_pause_state
		print(Globals.paused)
		resume_button.grab_focus()

func _on_unpause_pressed() -> void:
	AudioServer.set_bus_volume_db(music, 0)
	Click.play()
	var pause_event = InputEventAction.new()
	pause_event.action = "pause"
	pause_event.pressed = true
	Globals.paused = false
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	Input.parse_input_event(pause_event)

func _on_options_pressed() -> void:
	Click.play()
	Globals.options = true


func _on_unpause_mouse_entered() -> void:
	Hover.play()

func _on_options_mouse_entered() -> void:
	Hover.play()
