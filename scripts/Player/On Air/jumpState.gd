extends "res://scripts/Player/On Air/onAir.gd"

var inAirTime: float = 0.0

func enter() -> void:
	.enter()
	
	if self.actor.animationTree != null:
		self.actor.animationTree.set("parameters/on_air/current", 0)
	
	self.actor.velocity.y = self.actor.jumpForce
	inAirTime = 0.0
	
	self.actor.jumpSFX.play()

func physicsUpdate(delta: float) -> void:
	.physicsUpdate(delta)
	
	inAirTime += delta * 1000.0
	
	if self.actor.directionInput.y < 0:
		if inAirTime < self.actor.jumpSustain:
			self.actor.velocity.y = self.actor.jumpForce
	elif self.actor.directionInput.y == 0:
		inAirTime = self.actor.jumpSustain
	
	if self.actor.velocity.y > 0:
		emit_signal("finished", "falling")
	
	# if self.actor.is_on_floor() && self.actor.velocity.y >= 0.0:
		# inAirTime = 0

func get_name() -> String:
	return "jump"
