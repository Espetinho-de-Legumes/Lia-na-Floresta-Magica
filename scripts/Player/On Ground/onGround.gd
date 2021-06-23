extends "res://scripts/InterfaceState.gd"


func enter() -> void:
	self.actor.animationTree.set("parameters/ground_air_state/current", 0)

func update(delta: float) -> void:
	if self.actor.is_on_floor():
		emit_signal("finished", "onAir")

func physicsUpdate(delta: float) -> void:
	return
