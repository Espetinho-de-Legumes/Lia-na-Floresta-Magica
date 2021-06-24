extends "res://scripts/InterfaceState.gd"
# class_name onGround


func enter() -> void:
	if self.actor.animationTree != null:
		self.actor.animationTree.set("parameters/ground_air_state/current", 0)
	# print("On Ground State")

func handleInput(event: InputEvent) -> void:
	self.actor.basicInputs()

func update(delta: float) -> void:
	# if self.actor.velocity.y < 0:
		# emit_signal("finished", "jump")
	# elif self.actor.velocity.y > 0:
		# emit_signal("finished", "falling")
	if self.actor.hasFalledThrough:
		emit_signal("finished", "falling")

func physicsUpdate(delta: float) -> void:
	self.actor.applyGravity(delta)
	
	self.actor.move()

