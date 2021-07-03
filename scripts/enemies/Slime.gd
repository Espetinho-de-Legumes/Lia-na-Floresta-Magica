extends Area2D
signal player_died


func _on_Slime_body_entered(body: Node) -> void:
	if body.name == "Player":
		emit_signal("player_died")
