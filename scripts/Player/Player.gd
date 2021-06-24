extends "res://scripts/StateMachine.gd"

onready var animationTree: AnimationTree = get_node("AnimationTree")
onready var sprite: Sprite = get_node("Sprite")

export (float) var maxSpeed = 180.0
export (float) var acceleration = 600.0
export (float) var friction = -1000.0
export (float) var gravity = 2600.0 # pixel/sec
export (float) var jumpForce = -300.0
export (float) var jumpSustain = 220.0 # milisegundos

var velocity := Vector2.ZERO
var directionInput := Vector2.ZERO
var hasFalledThrough:bool = false
var collidingWithPlataform:bool = false

func basicInputs() -> void:
	if Input.is_action_pressed("right"):
		directionInput.x = 1
		sprite.flip_h = false
		
		if friction > 0:
			friction *= -1
	elif Input.is_action_pressed("left"):
		directionInput.x = -1
		sprite.flip_h = true
		
		if friction < 0:
			friction *= -1
	else:
		directionInput.x = 0
	
	if Input.is_action_just_pressed("jump"):
		directionInput.y = -1
	else:
		directionInput.y = 0
	
	if Input.is_action_pressed("Fall"):
		directionInput.y = 1
	
	if Input.is_action_just_released("jump"):
		directionInput.y = 0

func applyGravity(delta: float) -> void:
	velocity.y += gravity * delta

func move() -> void:
	velocity = move_and_slide(velocity, Vector2.UP)

func desacelerar(delta: float) -> void:
	velocity.x += friction * delta
	
	if (friction < 0 && velocity.x <= 0) || (friction > 0 && velocity.x >= 0):
		velocity.x = 0
		
		# if is_on_floor() && currentState != IDLE:
			# emit_signal("finished")

func acelerar(delta: float) -> void:
	velocity.x += directionInput.x * acceleration * delta
	
	if directionInput.x > 0:
		if velocity.x >= maxSpeed:
			velocity.x = maxSpeed
	else:
		if velocity.x <= -maxSpeed:
			velocity.x = -maxSpeed

func canJump() -> bool:
	return directionInput.y < 0 && is_on_floor()

func fallThroughPlataform() -> void:
	if hasFalledThrough:
		if !collidingWithPlataform:
			set_collision_mask_bit(1, true)
			hasFalledThrough = false
			return
	
	if canFallThrough():
		hasFalledThrough = true
		passThrough()

func canFallThrough() -> bool:
	return directionInput.y > 0 && is_on_floor() && !hasFalledThrough

func passThrough() -> void:
	set_collision_mask_bit(1, false)

func get_name() -> String:
	return "idle"
