extends "res://scripts/Player/On Ground/onGround.gd"

# var currentSFXPlaying
var GroundCheckerRay: RayCast2D
var mapOfGroundSounds: Dictionary

func enter() -> void: 
	.enter()
	
	if self.actor.animationTree != null:
		self.actor.animationTree.set("parameters/on_ground/current", 1)
	
	if GroundCheckerRay == null:
		GroundCheckerRay = self.actor.GroundCheckerRay
	
	if mapOfGroundSounds.empty():
		mapOfGroundSounds = {
			"Grass": self.actor.grassSFX,
			"Rock": self.actor.rockSFX
		}
	
	# self.actor.walkSFX.play()
	# currentSFXPlaying = "walkSFX"

func exit() -> void:
	.exit()
	
	# self.actor.walkSFX.stop()
	# self.actor.walkRockSFX.stop()

func physicsUpdate(delta: float) -> void:
	.physicsUpdate(delta)
	
	if self.actor.directionInput.x > 0 || self.actor.directionInput.x < 0:
		self.actor.acelerar(delta)
	else:
		self.actor.desacelerar(delta)
	
	if self.actor.velocity.x == 0:
		emit_signal("finished", "idle")
	
	playDynamicSound()

func playDynamicSound() -> void:
	var groundType = GroundCheckerRay.get_collider().name
	
	if groundType == "Cave":
		print("Play with Reverb")
	else:
		mapOfGroundSounds[groundType].play()

func get_name() -> String:
	return "walk"
