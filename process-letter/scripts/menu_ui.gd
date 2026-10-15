extends CanvasLayer

@onready var start_button = $VBoxContainer/Start
@onready var loading_screen = $Loading
@onready var options_screen = $OptionsUi

func _ready():
	MenuBg.play()
	start_button.grab_focus()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	loading_screen.modulate.a = 0.0
	loading_screen.visible = false
	
func _process(delta: float) -> void:
	if Globals.options:
		options_screen.visible = true
	else:
		options_screen.visible = false


func _on_start_pressed() -> void:
	Click.play()
	MenuBg.stream_paused = true
	
	loading_screen.visible = true
	var tween = create_tween()
	tween.tween_property(loading_screen, "modulate:a", 1.0, 0.5)
	await tween.finished
	get_tree().change_scene_to_file("res://src/main/level_a.tscn")


func _on_options_pressed() -> void:
	Click.play()
	Globals.options = true

func _on_start_mouse_entered() -> void:
	Hover.play()

func _on_options_mouse_entered() -> void:
	Hover.play()
