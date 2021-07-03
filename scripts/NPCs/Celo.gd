extends "res://scripts/NPCs/NPC.gd"
signal start_celo_quest
signal finish_celo_quest

var questStarted = false
var questFinished = false

func handleCustomLogic() -> void:
	if questStarted && !questFinished:
		if PlayerData.hasGlasses:
			questFinished = true
			hasFinished = true
			emit_signal("finish_celo_quest")

func _on_InitialDialog_dialogFinished() -> void:
	._on_InitialDialog_dialogFinished()
	
	questStarted = true
	emit_signal("start_celo_quest")
