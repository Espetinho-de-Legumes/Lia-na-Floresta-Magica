tool
extends Camera2D

export(NodePath) var alvo_path
export var offSetValue:int = 140

onready var player: Player = get_node(alvo_path)


func _get_configuration_warning() -> String:
	if (alvo_path == null):
		return "A câmera precisa seguir alguém"
	
	return ""

func _physics_process(delta: float) -> void:
	if !Engine.editor_hint:
		if player.get_velocity().x > 0:
			position.x = player.position.x + offSetValue
		elif player.get_velocity().x < 0:
			position.x = player.position.x - offSetValue
		
		# position.y = player.get_position().y
