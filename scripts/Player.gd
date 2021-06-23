extends KinematicBody2D

enum {
	IDLE,
	RUN,
	JUMP
}

onready var animationTree: AnimationTree = get_node("AnimationTree")
onready var sprite: Sprite = get_node("Sprite")

export (float) var maxSpeed = 340.0
export (float) var acceleration = 35.0
export (float) var friction = -20.0
export (float) var gravity = 2600.0 # pixel/sec
export (float) var jumpForce = -500.0
export (float) var jumpSustain = 220.0 # milisegundos

var inAirTime:float = 0.0
var hasJumped:bool = false
var hasFalledThrough:bool = false
var velocity := Vector2.ZERO
var directionInput := Vector2.ZERO
var currentState:int = IDLE
var prevState:float = IDLE
var collidingWithPlataform = false

func _ready() -> void:
	animationTree.set("parameters/ground_air_state/current", 0)
	animationTree.set("parameters/on_ground/current", 0)

func _unhandled_input(event: InputEvent) -> void:
	basicInputs()

func _process(delta: float) -> void:
	match currentState:
		IDLE:
			handleIdleState(delta)
		RUN:
			handleRunState(delta)
		JUMP:
			handleJumpState(delta)

func _physics_process(delta: float) -> void:
	applyGravity(delta)
	move()

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
	
	directionInput.normalized()

func applyGravity(delta) -> void:
	velocity.y += gravity * delta

func move() -> void:
	velocity = move_and_slide(velocity, Vector2.UP)

func handleIdleState(delta: float) -> void:
	animationTree.set("parameters/ground_air_state/current", 0)
	animationTree.set("parameters/on_ground/current", 0)
	desacelerar(delta)
	
	if directionInput.x > 0 or directionInput.x < 0:
		changeState(RUN)
	else:
		changeState(IDLE)
	
	if canJump():
		changeState(JUMP)
	
	fallThroughPlataform()

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

func handleRunState(delta: float) -> void:
	animationTree.set("parameters/ground_air_state/current", 0)
	animationTree.set("parameters/on_ground/current", 1)
	
	if directionInput.x > 0 || directionInput.x < 0:
		acelerar(delta)
	else:
		desacelerar(delta)
	
	if canJump():
		changeState(JUMP)
	
	fallThroughPlataform()

func desacelerar(delta: float) -> void:
	velocity.x += friction * delta
	
	if (friction < 0 && velocity.x <= 0) || (friction > 0 && velocity.x >= 0):
		velocity.x = 0
		
		if is_on_floor() && currentState != IDLE:
			changeState(IDLE)

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

func handleJumpState(delta: float) -> void:
	if hasJumped == false:
		animationTree.set("parameters/ground_air_state/current", 1)
		animationTree.set("parameters/on_air/current", 0)
		hasJumped = true
		velocity.y = jumpForce
		return
	
	inAirTime += delta * 1000.0
	if directionInput.y < 0:
		if inAirTime < jumpSustain:
			velocity.y = jumpForce
	elif directionInput.y == 0:
		inAirTime = jumpSustain
	
	if is_on_floor() && velocity.y >= 0.0:
		inAirTime = 0
		hasJumped = false
		changeState(IDLE)
	else:
		if directionInput.x > 0 || directionInput.x < 0:
			acelerar(delta)
		else:
			desacelerar(delta)
	
	if velocity.y > 0:
		animationTree.set("parameters/on_air/current", 1)

func changeState(newState: int) -> void:
	if currentState != newState:
		prevState = currentState
		currentState = newState


func _on_PassThroughDetection_body_entered(body: Node) -> void:
	collidingWithPlataform = true

func _on_PassThroughDetection_body_exited(body: Node) -> void:
	collidingWithPlataform = false
