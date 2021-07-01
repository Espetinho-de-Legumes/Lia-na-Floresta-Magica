tool
extends Area2D

export(PackedScene) var nextLevel

func _get_configuration_warning() -> String:
	if (nextLevel == null):
		return "Selecione qual será o próximo nível"
	
	return ""

func _process(delta: float) -> void:
	if len(get_overlapping_bodies()) > 0:
		print("ENTROU")
		GameGlobalManager.Level1Data.hasFinishedLevel = true
		get_tree().change_scene_to(nextLevel)
