extends "res://scripts/Player/On Ground/onGround.gd"
# class_name idle


func enter() -> void:
	.enter()
	
	if self.actor.animationTree != null:
		self.actor.animationTree.set("parameters/on_ground/current", 0)
	
	stop()
	# print("IDLE State")

func update(delta: float) -> void:
	.update(delta)
	
	if self.actor.directionInput.x > 0 || self.actor.directionInput.x < 0:
		emit_signal("finished", "walk")

func physicsUpdate(delta:float) -> void:
	.physicsUpdate(delta)
	self.actor.desacelerar(delta)

func get_name() -> String:
	return "idle"

func stop() -> void:
	self.actor.velocity.x = 0
	self.actor.velocity.y = 0
	self.actor.directionInput.x = 0
	self.actor.directionInput.y = 0
