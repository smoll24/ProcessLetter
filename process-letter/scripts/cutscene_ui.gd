
extends CanvasLayer

@onready var texture = $TextureRect
@onready var next_button = $Next
@onready var exit_button = $Exit

var cutscenes = {
	1: ["res://assets/temp/cutscene1.png"],
	2: ["res://assets/temp/cutscene2.png"],
	3: ["res://assets/temp/cutscene3.png"],
	4: ["res://assets/temp/cutscene4.png"],
	5: ["res://assets/temp/cutscene5.png"],
	6: ["res://assets/temp/cutscene6.png"],
	7: ["res://assets/temp/cutscene7.png"],
	8: ["res://assets/temp/cutscene8.png"]
}

var cut_num: int = 0
var active_cutscene: int = -1
var transitioning: bool = false
var cutscene_tween: Tween

func _ready() -> void:
	texture.modulate.a = 0.0
	next_button.modulate.a = 0.0
	exit_button.modulate.a = 0.0

	next_button.hide()
	exit_button.hide()
	hide()

func _process(_delta: float) -> void:
	if Globals.in_cutscene:
		if not visible:
			show_cutscene()
	elif visible and not transitioning:
		hide()

func show_cutscene() -> void:
	if transitioning:
		return
		
	if active_cutscene != Globals.current_cutscene:
		active_cutscene = Globals.current_cutscene
		cut_num = 0

	if not cutscenes.has(active_cutscene):
		return

	var images: Array = cutscenes[active_cutscene]

	if images.is_empty():
		return

	transitioning = true
	show()

	next_button.hide()
	exit_button.hide()

	texture.modulate.a = 0.0
	texture.texture = load(images[cut_num])

	cutscene_tween = create_tween()
	cutscene_tween.tween_property(
		texture, "modulate:a", 1.0, 0.6
	)

	await cutscene_tween.finished

	if cut_num < images.size() - 1:
		next_button.show()
		next_button.modulate.a = 0.0

		cutscene_tween = create_tween()
		cutscene_tween.tween_property(
			next_button, "modulate:a", 1.0, 0.3
		)
	else:
		exit_button.show()
		exit_button.modulate.a = 0.0

		cutscene_tween = create_tween()
		cutscene_tween.tween_property(
			exit_button, "modulate:a", 1.0, 0.3
		)

	await cutscene_tween.finished
	transitioning = false
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Globals.can_move = false
	Globals.can_talk = false


func _on_next_pressed() -> void:
	if transitioning:
		return
	Click.play()
	transitioning = true

	cutscene_tween = create_tween()
	cutscene_tween.set_parallel(true)
	cutscene_tween.tween_property(
		texture, "modulate:a", 0.0, 0.4
	)
	cutscene_tween.tween_property(
		next_button, "modulate:a", 0.0, 0.4
	)

	await cutscene_tween.finished

	cut_num += 1
	transitioning = false

	show_cutscene()


func _on_exit_pressed() -> void:
	if transitioning:
		return
	Click.play()
	transitioning = true

	cutscene_tween = create_tween()
	cutscene_tween.set_parallel(true)
	cutscene_tween.tween_property(
		texture, "modulate:a", 0.0, 0.4
	)

	var visible_button: Control = exit_button if exit_button.visible else next_button
	cutscene_tween.tween_property(
		visible_button, "modulate:a", 0.0, 0.4
	)

	await cutscene_tween.finished

	hide()
	Globals.in_cutscene = false
	transitioning = false
	
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	Globals.can_move = true
	Globals.can_talk = true


func _on_next_mouse_entered() -> void:
	Hover.play()


func _on_exit_mouse_entered() -> void:
	Hover.play()
