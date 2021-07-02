extends "res://scripts/NPCs/NPC.gd"

signal start_jotaro_quest
signal finish_jotaro_quest

export(int) var wormsToCollect = 15

var questStarted = false
var questFinished = false

func handleCustomLogic():
	if questStarted && !questFinished:
		var player = listOfOverlappedBodies[0]
		
		if player.collectedWorms >= wormsToCollect:
			emit_signal("finish_jotaro_quest")
			questFinished = true

func _on_InitialDialog_dialogFinished() -> void:
	._on_InitialDialog_dialogFinished()
	
	questStarted = true
	emit_signal("start_jotaro_quest")
