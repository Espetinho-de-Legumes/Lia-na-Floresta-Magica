extends "res://scripts/Levels/Level.gd"


func _on_Frey_finish_game() -> void:
	get_tree().change_scene_to(load("res://scripts/Levels/FinishScreen.gd"))
