extends CanvasLayer

@onready var label = $Label
@onready var slot1 = $Control/TextureButton
@onready var slot2 = $Control/TextureButton2
@onready var slot3 = $Control/TextureButton3

var solutions = {
	"prog1":["res://assets/workshop/item4.png",
			"res://assets/workshop/item3.png",
			"res://assets/workshop/item5.png"],
	"prog2":["res://assets/workshop/irem6.png",
			"res://assets/workshop/item8.png",
			"res://assets/workshop/item1.png"],
	"prog3":["res://assets/workshop/item2.png",
			"res://assets/workshop/item9.png",
			"res://assets/workshop/item0.png"]
	}

func _process(_delta):
	if Globals.in_workbench:
		self.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		self.visible = false
		

func _on_exit_pressed() -> void:
	Globals.in_workbench = false
	Globals.can_move = true
	Globals.can_talk = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _on_check_pressed() -> void:
	if solutions[Globals.status][0] == slot1.texture_normal.resource_path  \
	and solutions[Globals.status][1] == slot2.texture_normal.resource_path  \
	and solutions[Globals.status][2] == slot3.texture_normal.resource_path :
		label.text = "Correct!"
	else:
		label.text = "Incorrect."


func _on_reset_pressed() -> void:
	$Control/HBoxContainer/CenterContainer/TextureButton.texture_normal = preload("res://assets/workshop/item3.png")
	$Control/HBoxContainer/CenterContainer2/TextureButton.texture_normal = preload("res://assets/workshop/irem6.png")
	$Control/HBoxContainer/CenterContainer3/TextureButton.texture_normal = preload("res://assets/workshop/item8.png")
	$Control/HBoxContainer/CenterContainer4/TextureButton.texture_normal = preload("res://assets/workshop/item1.png")
	$Control/HBoxContainer/CenterContainer5/TextureButton.texture_normal = preload("res://assets/workshop/item5.png")
	$Control/HBoxContainer/CenterContainer6/TextureButton.texture_normal = preload("res://assets/workshop/item2.png")
	$Control/HBoxContainer/CenterContainer7/TextureButton.texture_normal = preload("res://assets/workshop/item4.png")
	$Control/HBoxContainer/CenterContainer8/TextureButton.texture_normal = preload("res://assets/workshop/item9.png")
	$Control/HBoxContainer/CenterContainer9/TextureButton.texture_normal = preload("res://assets/workshop/item0.png")
	$Control/TextureButton.texture_normal = preload("res://assets/workshop/empty2.png")
	$Control/TextureButton2.texture_normal = preload("res://assets/workshop/empty2.png")
	$Control/TextureButton3.texture_normal = preload("res://assets/workshop/empty2.png")
