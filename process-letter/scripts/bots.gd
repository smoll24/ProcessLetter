extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D


func _ready():
	if Globals.phase == 1:
		sprite.play('1_front_idle')
	elif Globals.phase == 2:
		sprite.play('2_front_idle')
	elif Globals.phase == 3:
		sprite.play('3_front_idle')

func _process(_delta):
	pass
