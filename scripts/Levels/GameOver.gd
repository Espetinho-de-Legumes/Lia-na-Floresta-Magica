extends Control

var scene = load("res://scenes/Levels/Level1.tscn")
var GameOverTheme = "MenuTheme"

func _ready() -> void:
	# Gui.setPauseSceneVisible(false)
	# Gui.setUserInterfaceVisible(false)
	if GlobalAudioManager.currentPlaying == null || GlobalAudioManager.currentPlaying.name != GameOverTheme:
		GlobalAudioManager.setAudio(GameOverTheme)


func playAgain() -> void:
	PlayerData.resetVariables()
	get_tree().change_scene_to(scene)

func exitGame() -> void:
	get_tree().quit()
