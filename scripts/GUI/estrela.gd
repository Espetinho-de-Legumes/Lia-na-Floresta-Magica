extends Sprite

onready var animationPlayer: AnimationPlayer = get_node("AnimationPlayer")

func _ready() -> void:
	animationPlayer.play("rotate")
