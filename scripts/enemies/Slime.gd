extends Area2D
signal player_died

onready var sfx:AudioStreamPlayer = get_node("SFX")

func _on_Slime_body_entered(body: Node) -> void:
	if body.name == "Player":
		sfx.play()
		emit_signal("player_died")
