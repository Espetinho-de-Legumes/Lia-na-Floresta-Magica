tool
extends Node2D

export(PackedScene) var nextLevel

func _get_configuration_warning() -> String:
	if (nextLevel == null):
		return "A câmera precisa seguir alguém"
	
	return ""


func _on_EndLevelTrigger_body_entered(body):
	get_tree().change_scene_to(nextLevel)
