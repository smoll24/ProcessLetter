extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D


func _ready():
	if Globals.phase == 1:
		sprite.play('phase1')
	elif Globals.phase == 2:
		sprite.play('phase2')
	elif Globals.phase == 3:
		sprite.play('phase3')

func _process(_delta):
	pass
