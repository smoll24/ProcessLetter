extends CanvasLayer

const BOT_ICON_SCENE = preload("res://src/ui/bot_icon.tscn")

@onready var hbox = $HBoxContainer 

var last_bot_count: int = 0

func _process(delta: float) -> void:
	var current_bot_count = Globals.bots_list.size()
	if current_bot_count != last_bot_count:
		update_bot_ui()
		last_bot_count = current_bot_count

func update_bot_ui() -> void:
	for child in hbox.get_children():
		child.queue_free()
		
	for bot in Globals.bots_list:
		var bot_icon = BOT_ICON_SCENE.instantiate()
		hbox.add_child(bot_icon)
