extends Node
signal game_over
signal game_completed
signal update_gui

var lives:int = 3 setget increase_lives
var collectedWorms:int = 0 setget collect_worms
var hasGlasses:bool = false setget set_glasses
var gems:int = 0 setget collect_gems
var currentLevel = "MainMenu"

func increase_lives(newValue: int) -> void:
	lives += newValue
	emit_signal("update_gui")
	
	if lives <= 0:
		emit_signal("game_over")

func collect_worms(newValue:int) -> void:
	collectedWorms += newValue
	
	emit_signal("update_gui")

func set_glasses(newValue:bool) -> void:
	hasGlasses = newValue
	
	emit_signal("update_gui")

func collect_gems(newValue:int) -> void:
	gems += newValue
	
	emit_signal("update_gui")

func resetVariables() -> void:
	lives = 3
	collectedWorms = 0
	hasGlasses = false
	gems = 0
	emit_signal("update_gui")
