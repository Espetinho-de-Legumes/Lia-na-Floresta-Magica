extends Node2D

export(String) var levelName

onready var player:Player = get_node("Characters/Player")
onready var startPoint: Area2D = get_node("AreaTriggers/StartPoint")
onready var endPoint: Area2D = get_node("AreaTriggers/EndPoint")

func _ready() -> void:
	if GlobalAudioManager.currentPlaying == null || GlobalAudioManager.currentPlaying.name != "MainTheme":
		GlobalAudioManager.setAudio("MainTheme")
	
	if GameGlobalManager[levelName + "Data"].hasFinishedLevel == false:
		player.position = startPoint.position
	else:
		player.position = endPoint.position
	
	if GlobalAudioManager.currentPlaying:
		if GlobalAudioManager.currentPlaying.name != "MainTheme":
			GlobalAudioManager.setAudio("MainTheme")
	
	# connect("reset_player", self, "_on_DeathZone_reset_player")

func _on_DeathZone_reset_player() -> void:
	player.position = startPoint.position
