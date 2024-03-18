extends CharacterBody2D

enum COW_STATE { IDLE, WALK }
@export var move_speed : float = 20
@export var idle_time : float = 5 #5
@export var walk_time : float = 2 #2

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get ("parameters/playback")
@onready var sprite = $Sprite2D
@onready var timer = $Timer


var move_direction : Vector2 = Vector2.ZERO

var current_state: COW_STATE = COW_STATE.IDLE

func _ready():
	pick_new_state()

func _physics_process(_delta):
	if(current_state == COW_STATE.WALK):
		velocity = move_direction * move_speed
		move_and_slide()
	
# Randomly generates a move direction
# can be either -1, 0, or 1 for x and y
func select_new_direction() :
	move_direction = Vector2(
		randi_range (-1,1),
		randi_range (-1, 1)
	)
	
	if (move_direction.x < 0):
		sprite.flip_h = true
	elif (move_direction.x >0) :
		sprite.flip_h = false
	
# Switch from walking to idling
func pick_new_state():
	var rando_numbo = randi_range (1,10)
	#change to walking
	#if (current_state == COW_STATE.IDLE):
	if (rando_numbo >= 1 && rando_numbo < 8):
		state_machine.travel ("walk_right")
		current_state = COW_STATE.WALK
		select_new_direction()
		timer.start(walk_time)
	#elif (current_state == COW_STATE.WALK):
	else:
		#change to idling
		state_machine.travel ("idle_right")
		current_state = COW_STATE.IDLE
		timer.start(idle_time)


func _on_timer_timeout():
	pick_new_state()
