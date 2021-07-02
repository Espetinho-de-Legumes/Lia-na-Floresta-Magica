extends Control

var scene = load("res://scenes/Levels/" + GameGlobalManager.playerStatus.lastScene + ".tscn")

func _ready() -> void:
	pass


func _on_CountDown_timeout() -> void:
	get_tree().change_scene_to(scene)
