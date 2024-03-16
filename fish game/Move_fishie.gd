extends CharacterBody2D

#parameters/idle/blend_position

@export var move_speed : float = 600

@export var starting_direction : Vector2 = Vector2(0,1)

@onready var animation_tree = $AnimationTree

@onready var state_machine = animation_tree.get("parameters/playback")



func _ready():
	update_animation_parameters (starting_direction)
	
func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up"),
	)
	
	update_animation_parameters (input_direction)
	
	velocity = input_direction.normalized() * move_speed
	
	move_and_slide()
	
	pick_new_state()

#func _physics_process(delta):
	#var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	#velocity = direction * 600
	#move_and_slide()
	
	#update_animation_parameters (direction)
	

	#if velocity.length() > 0.0:
		##get_node("animation").play_movement_animation()
	#else:
		#get_node("animation").play_idle_animation()
	
	
	
func update_animation_parameters (move_input : Vector2) :
	# Don't change animation parameters 1f there 1s no move input
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/walk/blend_position", move_input) 
		animation_tree.set("parameters/idle/blend_position", move_input)
		
func pick_new_state():
	if (velocity != Vector2.ZERO):
		state_machine.travel("walk")
	else:
		state_machine.travel ("idle")
