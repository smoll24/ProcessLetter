extends CanvasLayer

@onready var resume_button = $VBoxContainer/Unpause

@onready var options_screen = $VBoxContainer/Options

func _ready():
	visible = false

func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		Globals.paused = new_pause_state
		print(Globals.paused)
		resume_button.grab_focus()

func _on_unpause_pressed() -> void:
	var pause_event = InputEventAction.new()
	pause_event.action = "pause"
	pause_event.pressed = true
	Globals.paused = false
	Input.parse_input_event(pause_event)


func _on_options_pressed() -> void:
	options_screen.open()
	visible = false
