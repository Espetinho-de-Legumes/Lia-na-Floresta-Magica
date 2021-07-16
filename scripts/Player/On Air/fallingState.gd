extends "res://scripts/Player/On Air/onAir.gd"


func enter() -> void:
	.enter()
	
	if self.actor.animationTree != null:
		self.actor.animationTree.set("parameters/on_air/current", 1)

func exit() -> void:
	.exit()
	self.actor.directionInput.y = 0

func physicsUpdate(delta: float) -> void:
	.physicsUpdate(delta)
	
	if self.actor.is_on_floor():
		if self.actor.velocity.x == 0:
			emit_signal("finished", "idle")
		else:
			emit_signal("finished", "walk")
	
	self.actor.fallThroughPlataform()

func get_name() -> String:
	return "falling"
