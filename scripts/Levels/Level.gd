extends Node2D

export(String) var levelName
export(String) var MainLevelTheme = "MainTheme"

onready var player:Player = get_node("Characters/Player")
onready var startPoint: Area2D = get_node("AreaTriggers/StartPoint")
onready var endPoint: Area2D = get_node("AreaTriggers/EndPoint")

# var MainLevelTheme = "MainTheme"

func _ready() -> void:
	if GlobalAudioManager.currentPlaying == null || GlobalAudioManager.currentPlaying.name != MainLevelTheme:
		GlobalAudioManager.setAudio(MainLevelTheme)
	
	if GameGlobalManager[levelName + "Data"].hasFinishedLevel == false:
		player.position = startPoint.position
	else:
		player.position = endPoint.position
	
	if GlobalAudioManager.currentPlaying:
		if GlobalAudioManager.currentPlaying.name != MainLevelTheme:
			GlobalAudioManager.setAudio(MainLevelTheme)
	
	var enemiesNode:Node = get_node_or_null("Enemies")
	if enemiesNode:
		for children in enemiesNode.get_children():
			children.connect("game_over", self, "_on_Slime_game_over")

func _on_DeathZone_reset_player() -> void:
	player.position = startPoint.position

func _on_Slime_game_over() -> void:
	GameGlobalManager.playerStatus.lastScene = levelName
	get_tree().change_scene_to(load("res://scenes/Levels/GameOver.tscn"))
