extends CanvasLayer

@onready var label = $Label
@onready var slot1 = $Control/TextureButton
@onready var slot2 = $Control/TextureButton2
@onready var slot3 = $Control/TextureButton3

@onready var upgrade_message = $Upgrade
@onready var upgrade_sparkle = $Upgrade/Sparkle
@onready var upgrade_sprite = $Upgrade/Bots

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

func _process(delta):
	if Globals.in_workbench:
		self.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		self.visible = false
		
		
	if upgrade_message.visible:
		upgrade_sparkle.rotation += 1.0 * delta
		
	if Globals.status == "prog1":
		upgrade_sprite.play("bot1")
	elif Globals.status == "prog2":
		upgrade_sprite.play("bot2")
	elif Globals.status == "prog3":
		upgrade_sprite.play("bot3")
		

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
		upgrade_message.visible = true
		Globals.puzzle_step = 0
		if Globals.status == "prog1":
			Globals.status = "pre2"
			print("pre2")
		elif Globals.status == "prog2":
			Globals.status = "pre3"
			print("pre3")
		elif Globals.status == "prog3":
			Globals.status = "post3"
			print("post3")
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


func reload_scene():
	Globals.reloading = true
	Globals.stored_player_position = Globals.player_position
	get_tree().change_scene_to_file("res://src/main/level_a.tscn")

func _on_next_pressed() -> void:
	upgrade_message.visible = false
	Globals.in_workbench = false
	Globals.can_move = true
	Globals.can_talk = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	reload_scene()
