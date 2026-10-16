extends Node

var can_move = true
var can_talk = true
#0,1,2,3
var puzzle_phase = 0

var status: String = "pre1":
	set(value):
		if status == value:
			return

		status = value
		save_game()

#1,2,3
var phase:int
var in_room = true
var options = false

var ending = false

var music_volume: float = 0.0
var sounds_volume: float = 0.0

var interactions = {"purple":["post3"], "pink":["post3"],"blue":["post3"],
"teal":[],"violet":["post3"], "workbench":["prog1","prog2","prog3"],
"computer":["prog1","prog2","prog3","post4"]}

#post post 4 is when real ending is

#var interactions = {"purple":["prog3","pre1","prog1","pre2","prog2","pre3"],
#"pink":["prog3","pre3"], "blue":["prog3","prog2","pre3"],
#"teal":["prog3","pre1","prog1","pre2","prog2","pre3"],
#"violet":["prog3","pre1","prog1","pre2","prog2","pre3"],
#"workbench":["prog1","prog2","prog3"],
#"computer":["prog1","prog2","prog3"]}

var current_level = 0

var purple = false
var pink = false
var teal = false
var blue = false
var violet = false
var workbench = false
var workbench_type = 0
var in_workbench = false
var in_computer = false
var elevator = false
var in_elevator = false
var bot = false
var paused = false
var outside = false

var can_capture = false
var captured = 0

var book = false
var book_type = 1
var in_book = false

var in_cutscene = false

var blue_convo = false
var purple_convo = false
var violet_convo = false
var pink_convo = false

var current_cutscene = 0

#Indicates whether you can enter 1. Computer 2. Workshop 
var puzzle_step: int = 1:
	set(value):
		if puzzle_step == value:
			return

		puzzle_step = value
		save_game()
		
#Network, Sudoku, Logic, Password
var current_puzzle: String = "network":
	set(value):
		if current_puzzle == value:
			return

		current_puzzle = value
		save_game()

var player_position: Vector2
var stored_player_position: Vector2

var current_bot_instance: CharacterBody2D = null
var bots_list = []

var conversations = 0

var reloading = false

var cutscenes = []

func _process(_delta):
	if phase < 3:
		puzzle_phase = phase
	else:
		puzzle_phase = 2
	
	Dialogic.VAR.set_variable("State", status)
	
	if status == "prog4":
		can_capture = true
	
	if paused:
		can_move = false
		can_talk = false
		
	if status == "pre1" or status == "prog1":
		phase = 0
	if status == "pre2" or status == "prog2":
		phase = 1
	if status == "pre3" or status == "prog3":
		phase = 2
	if status == "post3" or status == "prog4" or status == "post4":
		phase = 3
	if pink_convo and blue_convo and purple_convo \
	and violet_convo and status == "post3":
		if "11" not in Globals.cutscenes:
			Globals.current_cutscene = 11
			Globals.in_cutscene = true
			Globals.cutscenes.append("11")
		status = "prog4"
		print("prog4")
	if bots_list == [] and captured > 2 and status == "prog4":
		status = "post4"
		puzzle_step = 1
		current_puzzle = "password"
		print("post4")
		
		


const SAVE_PATH = "user://savegame.json"


func save_game() -> void:
	var save_data = {
		"status": status,
		"phase": phase,
		"puzzle_phase": puzzle_phase,
		"current_level": current_level,
		"puzzle_step": puzzle_step,
		"current_puzzle": current_puzzle,
		"ending": ending,

		"purple": purple,
		"pink": pink,
		"teal": teal,
		"blue": blue,
		"violet": violet,
		"workbench": workbench,
		"workbench_type": workbench_type,
		"book": book,
		"book_type": book_type,
		"elevator": elevator,
		"outside": outside,
		"can_capture": can_capture,
		"captured": captured,

		"interactions": interactions,
		"blue_convo": blue_convo,
		"purple_convo": purple_convo,
		"violet_convo": violet_convo,
		"pink_convo": pink_convo,
		"conversations": conversations,

		"current_cutscene": current_cutscene,
		"cutscenes": cutscenes,

		"music_volume": music_volume,
		"sounds_volume": sounds_volume,

		"player_position": [
			player_position.x,
			player_position.y
		],
		"stored_player_position": [
			stored_player_position.x,
			stored_player_position.y
		],

		"bots_list": _get_bot_save_data()
	}

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	if file == null:
		push_error("Failed to open save file: " + str(FileAccess.get_open_error()))
		return

	file.store_string(JSON.stringify(save_data))
	file.close()

	print("Game saved successfully.")


func _get_bot_save_data() -> Array:
	var saved_bots: Array = []

	for bot_node in bots_list:
		if is_instance_valid(bot_node) and bot_node is Node:
			var bot_data = {
				"name": bot_node.name
			}

			if "bot_id" in bot_node:
				bot_data["bot_id"] = bot_node.get("bot_id")

			if bot_node is Node2D:
				bot_data["position"] = [
					bot_node.global_position.x,
					bot_node.global_position.y
				]

			saved_bots.append(bot_data)
		else:
			if typeof(bot_node) in [
				TYPE_STRING, TYPE_INT, TYPE_FLOAT, TYPE_BOOL
			]:
				saved_bots.append(bot_node)

	return saved_bots
	
var saved_bots_list: Array = []

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found. Starting new game.")
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)

	if file == null:
		push_error("Failed to open save file.")
		return

	var data = JSON.parse_string(file.get_as_text())
	file.close()

	if not data is Dictionary:
		push_error("Invalid save file.")
		return

	status = data.get("status", "pre2")
	phase = int(data.get("phase", 0))
	puzzle_phase = int(data.get("puzzle_phase", 0))
	current_level = int(data.get("current_level", 0))
	puzzle_step = int(data.get("puzzle_step", 1))
	current_puzzle = data.get("current_puzzle", "network")
	ending = data.get("ending", false)

	purple = data.get("purple", false)
	pink = data.get("pink", false)
	teal = data.get("teal", false)
	blue = data.get("blue", false)
	violet = data.get("violet", false)
	workbench = data.get("workbench", false)
	workbench_type = int(data.get("workbench_type", 0))
	book = data.get("book", false)
	book_type = int(data.get("book_type", 1))
	elevator = data.get("elevator", false)
	outside = data.get("outside", false)
	can_capture = data.get("can_capture", false)
	captured = int(data.get("captured", 0))

	interactions = data.get("interactions", interactions.duplicate(true))
	blue_convo = data.get("blue_convo", false)
	purple_convo = data.get("purple_convo", false)
	violet_convo = data.get("violet_convo", false)
	pink_convo = data.get("pink_convo", false)
	conversations = int(data.get("conversations", 0))

	current_cutscene = int(data.get("current_cutscene", 0))
	cutscenes = data.get("cutscenes", [])

	music_volume = float(data.get("music_volume", 0.0))
	sounds_volume = float(data.get("sounds_volume", 0.0))

	var pos = data.get("player_position", [0.0, 0.0])
	if pos is Array and pos.size() >= 2:
		player_position = Vector2(float(pos[0]), float(pos[1]))

	var stored_pos = data.get("stored_player_position", [0.0, 0.0])
	if stored_pos is Array and stored_pos.size() >= 2:
		stored_player_position = Vector2(
			float(stored_pos[0]), float(stored_pos[1])
		)

	saved_bots_list = data.get("bots_list", [])

	current_bot_instance = null
	bots_list.clear()
	can_move = true
	can_talk = true
	paused = false
	in_workbench = false
	in_computer = false
	in_elevator = false
	in_book = false
	in_cutscene = false
	options = false
	reloading = false

	print("Game loaded successfully.")

func delete_save() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var err = DirAccess.remove_absolute(
			ProjectSettings.globalize_path(SAVE_PATH)
		)

		if err != OK:
			push_error("Failed to delete save file: " + str(err))

func reset_game() -> void:
	can_move = true
	can_talk = true

	puzzle_phase = 0
	status = "pre1"
	phase = 0
	in_room = true
	options = false
	ending = false

	interactions = {
		"purple": ["post3"],
		"pink": ["post3"],
		"blue": ["post3"],
		"teal": [],
		"violet": ["post3"],
		"workbench": ["prog1", "prog2", "prog3"],
		"computer": ["prog1", "prog2", "prog3", "post4"]
	}

	current_level = 0

	purple = false
	pink = false
	teal = false
	blue = false
	violet = false
	workbench = false
	workbench_type = 0
	in_workbench = false
	in_computer = false
	elevator = false
	in_elevator = false
	bot = false
	paused = false
	outside = false

	can_capture = false
	captured = 0

	book = false
	book_type = 1
	in_book = false
	in_cutscene = false

	blue_convo = false
	purple_convo = false
	violet_convo = false
	pink_convo = false

	current_cutscene = 0
	puzzle_step = 1
	current_puzzle = "network"

	player_position = Vector2.ZERO
	stored_player_position = Vector2.ZERO

	current_bot_instance = null
	bots_list.clear()
	saved_bots_list.clear()

	conversations = 0
	reloading = false
	cutscenes.clear()

	print("New game started.")
