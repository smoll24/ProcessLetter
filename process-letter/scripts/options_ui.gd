extends CanvasLayer

func _ready() -> void:
	init_slider("Music", "Music")
	init_slider("Sounds", "Sound")
	init_slider("UI", "Sound")

func _process(delta: float) -> void:
	if Globals.options:
		self.visible = true
	else:
		self.visible = false

func _input(event):
		if event.is_action_pressed("pause"):
			if Globals.options:
				Globals.options = false

func init_slider(bus_name: String, slider_name: String) -> void:
	var bus_index: int = AudioServer.get_bus_index(bus_name)
	var slider: HSlider = get_node(slider_name)
	
	var db_val: float = AudioServer.get_bus_volume_db(bus_index)
	slider.value = db_to_linear(db_val)
	
	slider.value_changed.connect(func(val: float) -> void:
		_on_volume_changed(val, bus_index)
	)

func _on_volume_changed(linear_value: float, bus_index: int) -> void:
	var db_value: float = linear_to_db(linear_value)
	AudioServer.set_bus_volume_db(bus_index, db_value)


func _on_exit_pressed() -> void:
	Click.play()
	Globals.options = false
	
func _on_exit_mouse_entered() -> void:
	Hover.play()
