tool
extends Camera2D

export(NodePath) onready var alvo_path
export var offSetValue:int = 140

onready var Alvo:Player = get_node(alvo_path)

var offSet: int

func _get_configuration_warning() -> String:
	if (alvo_path == null):
		return "A câmera precisa seguir alguém"
	
	return ""

func _physics_process(delta: float) -> void:
	if Alvo.velocity.x > 0:
		offSet = offSetValue
	elif Alvo.velocity.x < 0:
		offSet = -offSetValue
	
	position.x = Alvo.get_global_position().x + offSet
	position.y = Alvo.get_global_position().y
