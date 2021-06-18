extends KinematicBody2D

enum {
	IDLE,
	RUN,
	JUMP
}

export (int) var maxSpeed = 400
export (int) var acceleration = 150
export (int) var friction = -60
export (int) var gravity = 1200 # pixel/sec

var velocity := Vector2.ZERO
var directionInput := Vector2.ZERO
var currentState:int = IDLE
var prevState:int = IDLE

func _process(delta: float) -> void:
	basicInputs()
	
	match currentState:
		IDLE:
			handleIdleState()
		RUN:
			handleRunState()
		JUMP:
			handleJumpState()
	
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
	
	directionInput.normalized()
	pass


func applyGravity(delta) -> void:
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += gravity * delta
	
	pass
	
func move() -> void:
	if directionInput.x == 0:
		desacelerar()
	else:
		acelerar()
	
	velocity = move_and_slide(velocity, Vector2.UP)
	pass

func desacelerar() -> void:
	velocity.x += friction
	
	if friction < 0:
		if velocity.x <= 0:
			velocity.x = 0
	else:
		if velocity.x >= 0:
			velocity.x = 0
	
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
	
func handleIdleState() -> void:
	if directionInput.x > 0 or directionInput.x < 0:
		print("Change State to Run")
	else:
		print("Change State to Idle")
	
	if directionInput.y < 0:
		print("Change State to Jump")
	pass

func handleRunState() -> void:
	pass

func handleJumpState() -> void:
	pass

func changeState(newState: int) -> void:
	if currentState != newState:
		prevState = currentState
		currentState = newState
	pass
