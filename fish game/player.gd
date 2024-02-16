extends CharacterBody2D

#variables
@export var MAX_SPEED = 300
@export var ACCELERATION = 1500
@export var FRICTION = 1200

@onready var axis = Vector2.ZERO

#physics
func _physics_process(delta):
	move(delta)
	
	
	
	

#input function
func get_input_axis():
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return axis.normalized()
	
#absolute value for how the player is trying to move

func move(delta):
	
	axis = get_input_axis()
	
	if axis == Vector2.ZERO: #this is if the player is not moving
		apply_friction(FRICTION * delta)
		
	else:
		apply_movement(axis * ACCELERATION * delta)

	move_and_slide()



func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	
	else:
		velocity = Vector2.ZERO #if friciton has been successfully applied to motion of 0
		
		
		
func apply_movement(accel):
	velocity += accel # will add accel to the velocity
	velocity = velocity.limit_length(MAX_SPEED)
	
