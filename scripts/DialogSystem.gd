tool
extends Node2D

signal dialogFinished

export(String, FILE, "*json") var dialogFile
export(bool) var showQuestMark = true

onready var dialogueContainer: Control = get_node("CanvasLayer/DialogContainer")
onready var NameLabel: Label = get_node("CanvasLayer/DialogContainer/DialogBox/Name")
onready var TextBox: RichTextLabel = get_node("CanvasLayer/DialogContainer/DialogBox/Text")
onready var endTimer: Timer = get_node("EndTimer")
onready var questMark = get_node("QuestMark")

var listOfDialogs = []
var currentIndex: int = -1
var currentCharacter: int = -1
var isActive: bool = false setget setActive

func _get_configuration_warning() -> String:
	if (dialogFile == null):
		return "Selecione o arquivo de dialogo"
	
	return ""

func _ready() -> void:
	setActive(false)
	listOfDialogs = loadDialog()
	questMark.visible = showQuestMark

func play() -> void:
	if isActive:
		return
	
	setActive(true)
	setPlayerActive(false)
	
	nextLine()

func _input(event: InputEvent) -> void:
	if !Engine.editor_hint:
		if event.is_action_pressed("use") && isActive:
			nextLine()

func loadDialog():
	var absolutePath
	if OS.has_feature("editor"):
		absolutePath = ProjectSettings.globalize_path(dialogFile)
	else:
		absolutePath = OS.get_executable_path().get_base_dir().plus_file(dialogFile)
	
	var file = File.new()
	if file.file_exists(absolutePath):
		file.open(absolutePath, file.READ)
		return parse_json(file.get_as_text())

func nextLine() -> void:
	currentIndex += 1
	currentCharacter = -1
	
	if currentIndex >= len(listOfDialogs):
		endTimer.start()
		return
	
	NameLabel.text = listOfDialogs[currentIndex].name + " Diz:"
	TextBox.text = listOfDialogs[currentIndex].says

func setActive(newValue:bool) -> void:
	isActive = newValue
	dialogueContainer.visible = newValue

func setPlayerActive(newValue: bool) -> void:
	var player = get_tree().get_root().find_node("Player", true, false)
	
	if player:
		player.setActive(newValue)


func _on_EndTimer_timeout() -> void:
	currentIndex = -1
	setActive(false)
	setPlayerActive(true)
	questMark.visible = false
	emit_signal("dialogFinished")
