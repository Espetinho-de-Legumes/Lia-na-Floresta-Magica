extends "res://scripts/NPCs/NPC.gd"
signal finish_game


func _on_InitialDialog_dialogFinished() -> void:
	emit_signal("finish_game")
