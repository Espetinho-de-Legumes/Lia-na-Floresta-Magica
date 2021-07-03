extends "res://scripts/NPCs/NPC.gd"

func _on_InitialDialog_dialogFinished() -> void:
	._on_InitialDialog_dialogFinished()
	
	PlayerData.hasGlasses = true
	print(PlayerData.hasGlasses)
