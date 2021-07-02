extends "res://scripts/Levels/Level.gd"


func _on_Jotaro_start_jotaro_quest() -> void:
	GlobalAudioManager.setAudio("FrogQuestTheme")
	# showgui

func _on_Jotaro_finish_jotaro_quest() -> void:
	GlobalAudioManager.setAudio("MainTheme")
