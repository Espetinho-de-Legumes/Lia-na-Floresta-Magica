extends "res://scripts/InterfaceState.gd"
# class_name onAir


func enter() -> void:
	if self.actor.animationTree != null:
		self.actor.animationTree.set("parameters/ground_air_state/current", 1)
	
	# print("On Air State")

func handleInput(event: InputEvent) -> void:
	self.actor.basicInputs()

func update(delta: float) -> void:
	if self.actor.velocity.y == 0 && self.actor.is_on_floor():
		if self.actor.velocity.x == 0:
			emit_signal("finished", "idle")
		else:
			emit_signal("finished", "walk")

func physicsUpdate(delta: float) -> void:
	self.actor.applyGravity(delta)
	
	if self.actor.directionInput.x > 0 || self.actor.directionInput.x < 0:
		self.actor.acelerar(delta)
	else:
		self.actor.desacelerar(delta)
	
	self.actor.move()
