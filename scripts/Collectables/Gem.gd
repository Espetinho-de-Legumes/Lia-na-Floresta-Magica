extends Area2D


func _on_Gem_body_entered(body: Node) -> void:
	PlayerData.gems += 1
	print(PlayerData.gems)
	queue_free()
