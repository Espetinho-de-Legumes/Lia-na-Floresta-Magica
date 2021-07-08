extends Node
signal game_over
signal game_completed
signal update_gui

var questsCompleted = {
	"Jotaro": false,
	"Celo": false
}
var deaths:int = 0 setget increase_deaths
var collectedWorms:int = 0 setget collect_worms
var hasGlasses:bool = false setget set_glasses
var gems:int = 0 setget collect_gems
var currentLevel = "MainMenu"

func increase_deaths(newValue:int) -> void:
	deaths += newValue

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
	deaths = 0
	collectedWorms = 0
	hasGlasses = false
	gems = 0
	questsCompleted = {
	"Jotaro": false,
	"Celo": false
}
	emit_signal("update_gui")
