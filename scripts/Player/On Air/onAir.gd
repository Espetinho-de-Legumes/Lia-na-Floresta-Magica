extends "res://scripts/InterfaceState.gd"


func enter() -> void:
	if self.actor.animationTree != null:
		self.actor.animationTree.set("parameters/ground_air_state/current", 1)
	

# func exit() -> void:
	# self.actor.directionInput.y = 0

func handleInput(event: InputEvent) -> void:
	self.actor.basicInputs()

func physicsUpdate(delta: float) -> void:
	if self.actor.directionInput.x > 0 || self.actor.directionInput.x < 0:
		self.actor.acelerar(delta)
	else:
		self.actor.desacelerar(delta)
