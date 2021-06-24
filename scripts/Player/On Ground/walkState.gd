extends "res://scripts/Player/On Ground/onGround.gd"
# class_name walk


func enter() -> void: 
	.enter()
	
	if self.actor.animationTree != null:
		self.actor.animationTree.set("parameters/on_ground/current", 1)
	
	print("Walk State")

func physicsUpdate(delta: float) -> void:
	.physicsUpdate(delta)
	if self.actor.directionInput.x > 0 || self.actor.directionInput.x < 0:
		self.actor.acelerar(delta)
	else:
		self.actor.desacelerar(delta)
	
	if self.actor.velocity.x == 0:
		emit_signal("finished", "idle")
	
	if self.actor.canJump():
		emit_signal("finished", "jump")
	
	# self.actor.fallThroughPlataform()

func get_name() -> String:
	return "walk"
