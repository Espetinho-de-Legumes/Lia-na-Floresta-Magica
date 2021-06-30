extends "res://scripts/Player/On Air/onAir.gd"
# class_name falling


func enter() -> void:
	.enter()
	
	if self.actor.animationTree != null:
		self.actor.animationTree.set("parameters/on_air/current", 1)

func physicsUpdate(delta: float) -> void:
	self.actor.fallThroughPlataform()

func get_name() -> String:
	return "falling"
