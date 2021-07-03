extends "res://scripts/NPCs/NPC.gd"
signal start_celo_quest
signal finish_celo_quest

onready var Glasses = get_node("Glasses")

var questStarted = false
var questFinished = false

func _ready() -> void:
	Glasses.visible = false

func handleCustomLogic() -> void:
	if questStarted && !questFinished:
		if PlayerData.hasGlasses:
			questFinished = true
			hasFinished = true
			Glasses.visible = true
			emit_signal("finish_celo_quest")

func _on_InitialDialog_dialogFinished() -> void:
	._on_InitialDialog_dialogFinished()
	
	questStarted = true
	emit_signal("start_celo_quest")
