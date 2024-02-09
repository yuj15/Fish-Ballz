extends CharacterBody2D


var player 

func _ready():
	player = get_node("/root/world/Move_fishie")


func _physics_process(delta): 
	var direction = global_position.direction_to(player.global_position)
	#global_position is defined as where this character is in the world
	velocity = direction * 300.0 
	move_and_slide()
