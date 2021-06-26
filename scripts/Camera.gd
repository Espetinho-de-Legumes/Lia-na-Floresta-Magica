tool
extends Camera2D

export(NodePath) var alvo_path


func _get_configuration_warning() -> String:
	if (alvo_path == null):
		return "A câmera precisa seguir alguém"
	
	return ""

func _process(delta: float) -> void:
	if alvo_path != null:
		var Alvo:KinematicBody2D = get_node(alvo_path)
		position = Alvo.get_position()
