extends Area2D

onready var sfx:AudioStreamPlayer = get_node("SFX")
onready var animationPlayer:AnimationPlayer = get_node("AnimationPlayer")

func _on_Gem_body_entered(body: Node) -> void:
	sfx.play()
	animationPlayer.play("FadeOut")

func collectCoin() -> void:
	# PlayerData.gems += 1
	PlayerData.collect_gems(1)
	# print(PlayerData.gems)
	queue_free()
