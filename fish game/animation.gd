extends Node2D

@onready var animate = $Player/AnimatedSprite2D

func _ready():
	animate.play("idle")
