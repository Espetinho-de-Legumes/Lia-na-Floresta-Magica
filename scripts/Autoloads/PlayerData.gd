extends Node
signal game_over
signal game_completed

var lives:int = 3 setget set_lives
var collectedWorms:int = 0
var hasGlasses:bool = false
var gems:int = 0


func set_lives(newValue: int) -> void:
	lives -= 1
	
	if lives <= 0:
		emit_signal("game_over")
