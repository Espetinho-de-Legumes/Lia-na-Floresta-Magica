extends "res://scripts/Levels/Level.gd"


func _on_Jotaro_finish_jotaro_quest() -> void:
	print("Quest do Jotaro terminada")


func _on_Jotaro_start_jotaro_quest() -> void:
	GlobalAudioManager.setAudio("FrogQuestTheme")
	# showgui
