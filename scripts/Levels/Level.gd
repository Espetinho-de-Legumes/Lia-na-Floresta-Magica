extends Node2D

export(String) var levelName
export(String) var MainLevelTheme = "MainTheme"

onready var player = get_node("Characters/Player")
onready var startPoint: Area2D = get_node("AreaTriggers/StartPoint")

func _ready() -> void:
	PlayerData.currentLevel = levelName
	Gui.verifiyGUIVisibilityForCurrentScene()
	
	# PlayerData.connect("game_over", self, "game_over")
	
	if GlobalAudioManager.currentPlaying == null || GlobalAudioManager.currentPlaying.name != MainLevelTheme:
		GlobalAudioManager.setAudio(MainLevelTheme)
	
	player.position = startPoint.position
	
	var enemiesNode:Node = get_node_or_null("Enemies")
	if enemiesNode:
		for children in enemiesNode.get_children():
			children.connect("player_died", self, "reset_player")

func reset_player() -> void:
	# PlayerData.increase_lives(-1)
	PlayerData.increase_deaths(1)
	player.playerStateMachine.changeState("idle")
	player.position = startPoint.position

func game_over():
	get_tree().change_scene_to(load("res://scenes/Levels/GameOver.tscn"))
