tool
extends Camera2D

export(NodePath) onready var alvo_path
export var offSet:int = 140

var Alvo: Player

func _ready():
	Alvo = get_node(alvo_path)

func _get_configuration_warning() -> String:
	if (alvo_path == null):
		return "A câmera precisa seguir alguém"
	
	return ""

func _physics_process(delta: float) -> void:
	if Alvo.velocity.x > 0:
		offSet = 120
	elif Alvo.velocity.x < 0:
		offSet = -120
		
	position.x = Alvo.get_position().x + offSet
	position.y = Alvo.get_position().y
