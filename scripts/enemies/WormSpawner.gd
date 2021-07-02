extends Area2D

onready var timerToActive: Timer = get_node("Timer")

var wormScene: PackedScene = load("res://scenes/enemies/worm.tscn")
var player: Player
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var randomDirection
var randomForceUp
var randomSpeed

func _on_WormSpawner_body_entered(body: Player) -> void:
	if body.velocity.y > 0:
		player = body
		playerChangeStateToJump()
		stopCollidingWithPlayer()
		call_deferred("spawnWormsAtRandomDirections")
		timerToActive.start()

func playerChangeStateToJump():
	player.playerStateMachine.changeState("jump")

func stopCollidingWithPlayer():
	set_collision_mask_bit(0, false)

func spawnWormsAtRandomDirections():
	rng.randomize()
	var quantitiesOfWorms = rng.randi_range(5, 10)
	for index in quantitiesOfWorms:
		var worm: Worm = wormScene.instance()
		var offSet: Vector2 = Vector2(30, 0)
		
		randomizeParamters()
		
		worm.direction = randomDirection
		worm.position.x = position.x
		worm.position.y = position.y
		
		worm.speed = randomSpeed
		worm.velocity.y += -randomForceUp
		get_parent().add_child(worm)

func randomizeParamters():
	rng.randomize()
	randomDirection = choose_randomly([-1, 1])
	randomForceUp = rng.randf_range(150, 350)
	randomSpeed = rng.randf_range(10, 60)

func choose_randomly(list_of_entries):
	return list_of_entries[rng.randi() % list_of_entries.size()]

func _on_Timer_timeout() -> void:
	set_collision_mask_bit(0, true)
