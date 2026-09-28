extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D


func _ready():
	pass
	
func _process(_delta):
	if Globals.phase == 1 or Globals.phase == 0:
		sprite.play('phase1')
	elif Globals.phase == 2:
		sprite.play('phase2')
	elif Globals.phase == 3:
		sprite.play('phase3')
