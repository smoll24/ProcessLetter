
extends CanvasLayer

@onready var texture = $TextureRect
@onready var next_button = $Next
@onready var exit_button = $Exit

var cutscenes = {1: ["res://assets/cutscenes/1/1a.png",
	"res://assets/cutscenes/1/1b.png",
	"res://assets/cutscenes/1/1c.png",
	"res://assets/cutscenes/1/1d.png",
	"res://assets/cutscenes/1/1e.png",
	"res://assets/cutscenes/1/1f.png"],
	2: ["res://assets/cutscenes/2/2a.png",
	"res://assets/cutscenes/2/2b.png",
	"res://assets/cutscenes/2/2c.png",
	"res://assets/cutscenes/2/2d.png",
	"res://assets/cutscenes/2/2e.png"],
	3: ["res://assets/cutscenes/3/3a.png",
	"res://assets/cutscenes/3/3b.png",
	"res://assets/cutscenes/3/3c.png",
	"res://assets/cutscenes/3/3d.png"],
	4: ["res://assets/cutscenes/4/4a.png",
	"res://assets/cutscenes/4/4b.png",
	"res://assets/cutscenes/4/4c.png"],
	10: ["res://assets/cutscenes/5/5c.png",
	"res://assets/cutscenes/5/5b.png",
	"res://assets/cutscenes/5/5a.png"],
	5: ["res://assets/cutscenes/6/6a.png"],
	6: ["res://assets/cutscenes/7/7b.png",
	"res://assets/cutscenes/7/7a.png",
	"res://assets/cutscenes/7/7c.png",
	"res://assets/cutscenes/7/7d.png"],
	7: ["res://assets/cutscenes/8/8a.png",
	"res://assets/cutscenes/8/8b.png",
	"res://assets/cutscenes/8/8c.png",
	"res://assets/cutscenes/8/8d.png"],
	9: ["res://assets/cutscenes/9/9a.png",
	"res://assets/cutscenes/9/9b.png",
	"res://assets/cutscenes/9/9c.png",
	"res://assets/cutscenes/9/9d.png",
	"res://assets/cutscenes/9/9e.png",
	"res://assets/cutscenes/9/9f.png",
	"res://assets/cutscenes/9/9g.png",
	"res://assets/cutscenes/9/9h.png",
	"res://assets/cutscenes/9/9j.png",
	"res://assets/cutscenes/9/9k.png",
	#"res://assets/cutscenes/9/9l.png",
	],
	11: ["res://assets/cutscenes/11/11a.png",
	"res://assets/cutscenes/11/11b.png",
	"res://assets/cutscenes/11/11c.png",
	"res://assets/cutscenes/11/11d.png",
	"res://assets/cutscenes/11/11e.png",
	"res://assets/cutscenes/11/11g.png",],
	12: ["res://assets/cutscenes/12/12a.png",
	"res://assets/cutscenes/12/12b.png",
	"res://assets/cutscenes/12/12c.png",
	"res://assets/cutscenes/12/12d.png",
	"res://assets/cutscenes/12/12e.png",
	"res://assets/cutscenes/12/12j.png",
	"res://assets/cutscenes/12/12g.png",
	"res://assets/cutscenes/12/12h.png",
	"res://assets/cutscenes/12/12k.png",
	"res://assets/cutscenes/12/12l.png",
	"res://assets/cutscenes/12/12m.png",
	"res://assets/cutscenes/12/12n.png",
	"res://assets/cutscenes/12/12o.png",
	"res://assets/cutscenes/12/12p.png",],
	13: ["res://assets/cutscenes/13/13a.png",
	"res://assets/cutscenes/13/13b.png",
	"res://assets/cutscenes/13/13c.png",]
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
