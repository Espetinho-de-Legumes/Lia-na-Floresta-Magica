extends Area2D
signal reset_player

func _ready() -> void:
	connect("body_entered", self, "_on_DeathZone_body_entered")

func _on_DeathZone_body_entered(body: Node) -> void:
	emit_signal("reset_player")
