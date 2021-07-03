extends Control

var scene = load("res://scenes/Levels/Level1.tscn")
var GameOverTheme = "MainTheme"

func _ready() -> void:
	if GlobalAudioManager.currentPlaying == null || GlobalAudioManager.currentPlaying.name != GameOverTheme:
		GlobalAudioManager.setAudio(GameOverTheme)


func _on_CountDown_timeout() -> void:
	get_tree().change_scene_to(scene)
