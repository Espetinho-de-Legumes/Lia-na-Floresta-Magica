extends KinematicBody2D

enum {
	IDLE,
	RUN,
	JUMP
}

export (int) var maxSpeed = 340
export (int) var acceleration = 35
export (int) var friction = -20
export (int) var gravity = 2600 # pixel/sec
export (int) var jumpForce = -650
export (float) var jumpSustain = 250 # milisegundos

var inAirTime:float = 0
var velocity := Vector2.ZERO
var directionInput := Vector2.ZERO
var currentState:int = IDLE
var prevState:int = IDLE


func _unhandled_input(event: InputEvent) -> void:
	basicInputs()
	
	pass

func _process(delta: float) -> void:
	match currentState:
		IDLE:
			handleIdleState(delta)
		RUN:
			handleRunState(delta)
		JUMP:
			handleJumpState(delta)
	
	pass

func _physics_process(delta: float) -> void:
	applyGravity(delta)
	move()
	
	pass

func basicInputs() -> void:
	if Input.is_action_pressed("right"):
		directionInput.x = 1
		
		if friction > 0:
			friction *= -1
	elif Input.is_action_pressed("left"):
		directionInput.x = -1
		
		if friction < 0:
			friction *= -1
	else:
		directionInput.x = 0
	
	if Input.is_action_just_pressed("jump"):
		directionInput.y = -1
	else:
		directionInput.y = 0
	
	directionInput.normalized()
	pass

func applyGravity(delta) -> void:
	velocity.y += gravity * delta
	
	pass
	
func move() -> void:
	velocity = move_and_slide(velocity, Vector2.UP)
	
	pass

func handleIdleState(delta: float) -> void:
	desacelerar()
	
	if directionInput.x > 0 or directionInput.x < 0:
		changeState(RUN)
	else:
		changeState(IDLE)
	
	if directionInput.y < 0:
		changeState(JUMP)
	pass

func handleRunState(delta: float) -> void:
	if directionInput.x > 0 || directionInput.x < 0:
		acelerar()
	else:
		desacelerar()
	
	if directionInput.y < 0:
		changeState(JUMP)
	
	pass

func desacelerar() -> void:
	velocity.x += friction
	
	if (friction < 0 && velocity.x <= 0) || (friction > 0 && velocity.x >= 0):
		velocity.x = 0
		
		if is_on_floor() && currentState != IDLE:
			changeState(IDLE)
	
	pass

func acelerar() -> void:
	velocity.x += directionInput.x * acceleration
	
	if directionInput.x > 0:
		if velocity.x >= maxSpeed:
			velocity.x = maxSpeed
	else:
		if velocity.x <= -maxSpeed:
			velocity.x = -maxSpeed
	
	pass

func handleJumpState(delta: float) -> void:
	if directionInput.y < 0:
		if inAirTime < (jumpSustain / 1000):
			velocity.y = jumpForce
			inAirTime += delta
	else:
		inAirTime = jumpSustain/1000
	
	if is_on_floor():
		if directionInput.y == 0:
			inAirTime = 0
			changeState(IDLE)
	else:
		if directionInput.x > 0 || directionInput.x < 0:
			acelerar()
		else:
			desacelerar()
	pass

func changeState(newState: int) -> void:
	if currentState != newState:
		prevState = currentState
		currentState = newState
	pass
