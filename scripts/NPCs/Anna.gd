extends "res://scripts/NPCs/NPC.gd"

onready var finishGameDialogue = get_node("FinishGameDialog")

var hasFineshed:bool = false

func handleCustomLogic() -> void:
	var player = listOfOverlappedBodies[0]
	
	if player.hasCompletedMainQuest:
		startFinishGameDialog()

func startFinishGameDialog() -> void:
	print("Finish Game")
	finishGameDialogue.play()
