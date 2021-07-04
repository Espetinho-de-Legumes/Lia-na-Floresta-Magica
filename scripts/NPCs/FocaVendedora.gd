extends "res://scripts/NPCs/NPC.gd"

export(int) var expectedGems = 10

func _on_InitialDialog_dialogFinished() -> void:
	# ._on_InitialDialog_dialogFinished()
	print(hasTalked)
	if PlayerData.gems >= expectedGems:
		PlayerData.collect_gems(-10)
		PlayerData.hasGlasses = true
		hasTalked = true
		print(PlayerData.hasGlasses)
