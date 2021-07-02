extends Area2D
signal game_over


func _on_Slime_body_entered(body: Node) -> void:
	if body.name == "Player":
		emit_signal("game_over")
