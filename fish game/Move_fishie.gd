extends CharacterBody2D

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 600
	move_and_slide()
	
	#this next part is when I add animations just remove"#"
	#if velocity.length() > 0.0:
	#	get_node("animation").play_movement_animation()
	#else:
	#	get_node("animation").play_idle_animation()
	
	