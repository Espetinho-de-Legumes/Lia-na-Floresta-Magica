extends KinematicBody2D
class_name Worm

export(float) var gravity = 1200.0

onready var timer: Timer = get_node("Timer")

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var velocity: Vector2 = Vector2.ZERO
var speed = 50.0
var direction: int = 1

func _ready() -> void:
	rng.randomize()
	var randomVanishedTime = rng.randf_range(1.5, 2.5)
	
	timer.start(randomVanishedTime)

func _physics_process(delta: float) -> void:
	if is_on_wall():
		direction *= -1
	
	applyGravity(delta)
	handleDirection()
	move(delta)

func applyGravity(delta: float):
	velocity.y += gravity * delta

func handleDirection():
	if direction == 1:
		velocity.x = speed
	else:
		velocity.x = -speed

func move(delta: float):
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Timer_timeout() -> void:
	queue_free()
