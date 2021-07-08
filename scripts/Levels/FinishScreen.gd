extends Control

onready var Quadro1:Sprite = get_node("Quadro1")
onready var Quadro2:Sprite = get_node("Quadro2")
onready var Quadro3:Label = get_node("Quadro3")

onready var playerStatus:TextureRect = get_node("PlayerStatus")
onready var deathsLabel:Label = get_node("PlayerStatus/HBoxContainer/Deaths")
onready var starsLabel:Label = get_node("PlayerStatus/HBoxContainer/Stars")

export(String) var mainLevelTheme = "MenuTheme"

var listaDeQuadros
var index = -1
var levelName = "FinishScreen"

func _ready() -> void:
	PlayerData.currentLevel = levelName
	Gui.on_update_gui()
	GlobalAudioManager.setAudio(mainLevelTheme)
	
	hideEverything()
	
	listaDeQuadros = [Quadro1, Quadro2, Quadro3]
	nextQuadro()

func nextQuadro() -> void:
	index += 1
	
	if index >= len(listaDeQuadros):
		showPlayerData()
		return
	
	var quadroAtual = listaDeQuadros[index]
	quadroAtual.visible = true
	quadroAtual.get_node("AnimationPlayer").play("FadeIn")

func hideEverything() -> void:
	Quadro1.visible = false
	Quadro2.visible = false
	Quadro3.visible = false
	playerStatus.visible = false

func showPlayerData() -> void:
	var stars = 1 # Por completar o jogo, ganha 1 estrela
	deathsLabel.text = "Mortes: %s" % PlayerData.deaths
	
	if PlayerData.questsCompleted.Jotaro:
		stars += 1
	if PlayerData.questsCompleted.Celo:
		stars += 1
	
	starsLabel.text = "Estrelas: %s" % stars
	playerStatus.visible = true


func _on_CountDown_timeout() -> void:
	nextQuadro()

func _on_PlayAgain_button_up() -> void:
	PlayerData.resetVariables()
	get_tree().change_scene_to(load("res://scenes/Levels/Level1.tscn"))


func _on_Quit_button_up() -> void:
	get_tree().quit()
