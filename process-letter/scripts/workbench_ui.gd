extends CanvasLayer

@onready var label = $Label
@onready var slot1 = $Control/TextureButton
@onready var slot2 = $Control/TextureButton2
@onready var slot3 = $Control/TextureButton3

var solutions = {
	"prog1":["res://assets/workshop/item3.png",
			"res://assets/workshop/item4.png",
			"res://assets/workshop/item5.png"],
	"prog2":["res://assets/workshop/item1.png",
			"res://assets/workshop/irem6.png",
			"res://assets/workshop/item8.png"],
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
