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


#attack function

#extends KinematicBody2D

# Variables
var speed = 200
var attackRange = 50
var attackDamage = 10
var attackCooldown = 1.0
var lastAttackTime = 0.0

var attackSound # Add your attack sound here

func _readyy():
	pass # Initialization code goes here

func _process(delta):
	# Movement logic (You can customize this based on your game's needs)
	var movement = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		movement.x += 1
	if Input.is_action_pressed("move_left"):
		movement.x -= 1
	if Input.is_action_pressed("move_down"):
		movement.y += 1
	if Input.is_action_pressed("move_up"):
		movement.y -= 1

	# Normalize the movement vector to avoid faster diagonal movement
	movement = movement.normalized()

	# Move the character
	move_and_slide(movement * speed)

	# Attack logic
	if Input.is_action_just_pressed("attack") and can_attack():
		attack()
		lastAttackTime = OS.get_system_time()

func can_attack():
	# Check if enough time has passed since the last attack
	return OS.get_system_time() >= lastAttackTime + attackCooldown

func attack():
	# Perform attack logic here (e.g., detect enemies within range and deal damage to them)
	var enemies = get_tree().get_nodes_in_group("enemies") # Assuming enemies are in a group called "enemies"

for enemy in enemies:
	var distance = self.global_position.distance_to(enemy.global_position)
	if distance <= attackRange:
		enemy.take_damage(attackDamage)

	# Play attack sound for when i get it
	#if attackSound:
		#$AudioStreamPlayer.play(attackSound)
