extends "res://scripts/Player/On Ground/onGround.gd"
# class_name walk

var currentSFXPlaying


func enter() -> void: 
	.enter()
	
	if self.actor.animationTree != null:
		self.actor.animationTree.set("parameters/on_ground/current", 1)
	
	self.actor.walkSFX.play()
	currentSFXPlaying = "walkSFX"
	
	# print("Walk State")

func exit() -> void:
	.exit()
	
	self.actor.walkSFX.stop()
	self.actor.walkRockSFX.stop()

func physicsUpdate(delta: float) -> void:
	.physicsUpdate(delta)
	if self.actor.directionInput.x > 0 || self.actor.directionInput.x < 0:
		self.actor.acelerar(delta)
	else:
		self.actor.desacelerar(delta)
	
	if self.actor.velocity.x == 0:
		emit_signal("finished", "idle")

func get_name() -> String:
	return "walk"
