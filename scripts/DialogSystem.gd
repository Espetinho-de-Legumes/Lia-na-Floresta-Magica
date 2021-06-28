tool
extends CanvasLayer

export(String, FILE, "*json") var dialogFile

onready var dialogueContainer: Control = get_node("dialogueContainer")
onready var NameLabel: Label = get_node("dialogueContainer/DialogBox/Name")
onready var TextBox: RichTextLabel = get_node("dialogueContainer/DialogBox/Text")
onready var endTimer: Timer = get_node("EndTimer")
onready var characterSpeed: Timer = get_node("CharacterSpeed")

var listOfDialogs = []
var currentIndex: int = -1
var currentCharacter: int = -1
var isActive = false setget setActive

func _get_configuration_warning() -> String:
	if (dialogFile == null):
		return "Selecione o arquivo de dialogo"
	
	return ""

func _ready() -> void:
	setActive(false)
	listOfDialogs = loadDialog()
	pass

func play() -> void:
	if isActive:
		return
	
	setActive(true)
	setPlayerActive(false)
	
	nextLine()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use") && isActive:
		nextLine()

func loadDialog():
	var file = File.new()
	if file.file_exists(dialogFile):
		file.open(dialogFile, file.READ)
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
