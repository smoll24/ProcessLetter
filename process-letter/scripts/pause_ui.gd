extends CanvasLayer

@onready var resume_button = $VBoxContainer/Unpause

@onready var options_screen = $VBoxContainer/Options

var music: int = AudioServer.get_bus_index("Music")
var sounds: int = AudioServer.get_bus_index("Sounds")

func _ready():
	visible = false
	
func _process(_delta: float) -> void:
	if self.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		AudioServer.set_bus_volume_db(music, -15)
		AudioServer.set_bus_volume_db(sounds, -15)
	else: 
		AudioServer.set_bus_volume_db(music, 0.0)
		AudioServer.set_bus_volume_db(sounds, 0.0)
		

func _input(event):
	if event.is_action_pressed("pause"):
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
	#options_screen.open()
	#visible = false


func _on_unpause_mouse_entered() -> void:
	Hover.play()

func _on_options_mouse_entered() -> void:
	Hover.play()
