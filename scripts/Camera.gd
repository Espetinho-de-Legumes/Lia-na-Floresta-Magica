tool
extends Camera2D

export(NodePath) var alvo_path

onready var player: Player = get_node(alvo_path)

func _get_configuration_warning() -> String:
	if (alvo_path == null):
		return "A câmera precisa seguir alguém"
	
	return ""

func _physics_process(delta: float) -> void:
	if !Engine.editor_hint:
		position = player.position
