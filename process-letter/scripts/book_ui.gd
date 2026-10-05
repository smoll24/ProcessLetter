extends CanvasLayer

@onready var technopoly = $Technopoly
@onready var foucault = $Foucault
@onready var gramsci = $Gramsci
@onready var metropolis = $Metropolis

func _process(_delta):
	if Globals.in_book:
		self.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		self.visible = false

	if Globals.book_type == 0:
		technopoly.visible = true
		foucault.visible = false
		gramsci.visible = false
		metropolis.visible = false
	elif Globals.book_type == 1:
		technopoly.visible = false
		foucault.visible = true
		gramsci.visible = false
		metropolis.visible = false
	elif Globals.book_type == 2:
		technopoly.visible = false
		foucault.visible = false
		gramsci.visible = true
		metropolis.visible = false
	elif Globals.book_type == 3:
		technopoly.visible = false
		foucault.visible = false
		gramsci.visible = false
		metropolis.visible = true



func _on_exit_pressed() -> void:
	Globals.in_book = false
	Globals.can_move = true
	Globals.can_talk = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
