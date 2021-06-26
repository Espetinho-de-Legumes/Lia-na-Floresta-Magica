extends KinematicBody2D
class_name Player


onready var animationTree: AnimationTree = get_node("AnimationTree")
onready var sprite: Sprite = get_node("Sprite")
onready var jumpSFX:AudioStreamPlayer2D = get_node("SFX/jumpSFX")

export (int) var maxSpeed = 180
export (int) var acceleration = 600
export (int) var friction = -1000
export (int) var gravity = 2600 # pixel/sec
export (int) var jumpForce = -300
export (int) var jumpSustain = 220 # milisegundos

var velocity := Vector2.ZERO
var directionInput := Vector2.ZERO
var hasFalledThrough:bool = false
var collidingWithPlataform:bool = false

var StateMachine: StateMachine = load("res://scripts/StateMachine.gd").new()

func _ready() -> void:
	var listOfStates:Array = [
	"res://scripts/Player/On Ground/idleState.gd",
	"res://scripts/Player/On Ground/walkState.gd",
	"res://scripts/Player/On Air/jumpState.gd",
	"res://scripts/Player/On Air/fallingState.gd"
	]
	
	StateMachine.init(self, listOfStates)

func _unhandled_input(event: InputEvent) -> void:
	StateMachine.currentState.handleInput(event)

func _process(delta: float) -> void:
	StateMachine.currentState.update(delta)

func _physics_process(delta: float) -> void:
	applyGravity(delta)
	StateMachine.currentState.physicsUpdate(delta)
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
	
	# if Input.is_action_just_released("jump"):
		# directionInput.y = 0

func applyGravity(delta: float) -> void:
	velocity.y += gravity * delta

func move() -> void:
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if velocity.y > 0 && velocity.y < 0.5:
		velocity.y = 0

func desacelerar(delta: float) -> void:
	velocity.x += friction * delta
	
	if (friction < 0 && velocity.x <= 0) || (friction > 0 && velocity.x >= 0):
		velocity.x = 0

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

func get_position() -> Vector2:
	return position

func _on_PassThroughDetection_body_entered(body: Node) -> void:
	collidingWithPlataform = true


func _on_PassThroughDetection_body_exited(body: Node) -> void:
	collidingWithPlataform = false
