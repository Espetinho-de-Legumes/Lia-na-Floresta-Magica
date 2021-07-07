tool
extends Area2D

export(PackedScene) var nextLevel

func _get_configuration_warning() -> String:
	if (nextLevel == null):
		return "Selecione qual será o próximo nível"
	
	return ""

func _process(delta: float) -> void:
	if not Engine.editor_hint:
		if len(get_overlapping_bodies()) > 0:
			get_tree().change_scene_to(nextLevel)
