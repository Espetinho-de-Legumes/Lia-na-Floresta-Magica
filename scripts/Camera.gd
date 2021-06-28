tool
extends Camera2D

export(NodePath) var alvo_path
export var offSetValue:int = 140

# onready var Alvo: Jogador = get_node(alvo_path)
var offSet: int = 0

func _get_configuration_warning() -> String:
	if (alvo_path == null):
		return "A câmera precisa seguir alguém"
	
	return ""

func _physics_process(delta: float) -> void:
	var Alvo: Player = get_node(alvo_path)
	
	# position = Alvo.get_position()
	if Alvo.get_velocity().x > 0:
		offSet = offSetValue
	elif Alvo.get_velocity().x < 0:
		offSet = -offSetValue
	
	position.x = Alvo.get_position().x + offSet
	position.y = Alvo.get_position().y
