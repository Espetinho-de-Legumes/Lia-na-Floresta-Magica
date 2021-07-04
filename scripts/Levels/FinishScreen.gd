extends Control

onready var Quadro1:Sprite = get_node("Quadro1")
onready var Quadro2:Sprite = get_node("Quadro2")
onready var Quadro3:Label = get_node("Quadro3")

var listaDeQuadros
var index = -1
var levelName = "GameOverScene"

func _ready() -> void:
	PlayerData.currentLevel = levelName
	Gui.on_update_gui()
	GlobalAudioManager.setAudio("MenuTheme")
	Quadro1.visible = false
	Quadro2.visible = false
	Quadro3.visible = false
	
	listaDeQuadros = [Quadro1, Quadro2, Quadro3]
	nextQuadro()

func nextQuadro() -> void:
	index += 1
	
	if index >= len(listaDeQuadros):
		return
	
	var quadroAtual = listaDeQuadros[index]
	quadroAtual.visible = true
	quadroAtual.get_node("AnimationPlayer").play("FadeIn")


func _on_CountDown_timeout() -> void:
	nextQuadro()
