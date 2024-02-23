extends Node2D


@onready var animate = $"pew pew/pewpewmove/AnimatedSprite2D"

func _ready():
	animate.play("default")
