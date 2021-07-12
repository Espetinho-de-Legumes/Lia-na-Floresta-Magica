extends "res://scripts/InterfaceState.gd"


func enter() -> void:
	if self.actor.animationTree != null:
		self.actor.animationTree.set("parameters/ground_air_state/current", 0)

func handleInput(event: InputEvent) -> void:
	self.actor.basicInputs()

func update(delta: float) -> void:
	if self.actor.velocity.y > 0:
	 emit_signal("finished", "falling")
	
	if self.actor.canJump():
		emit_signal("finished", "jump")
	
	self.actor.fallThroughPlataform()
