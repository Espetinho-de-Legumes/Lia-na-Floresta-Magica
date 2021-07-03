extends Area2D

onready var initialDialog = get_node_or_null("InitialDialog")
onready var onQuestDialog = get_node_or_null("OnQuestDialog")
onready var endDialog = get_node_or_null("EndDialog")

var hasTalked = false
var hasFinished = false
var listOfOverlappedBodies

func _ready():
	if initialDialog:
		initialDialog.connect("dialogFinished", self, "_on_InitialDialog_dialogFinished")
	
	if onQuestDialog == null:
		hasFinished = true

func _input(event: InputEvent) -> void:
	listOfOverlappedBodies = get_overlapping_bodies()
	
	if event.is_action_pressed("use") && len(listOfOverlappedBodies) > 0:
		handleCustomLogic()
		
		if !hasTalked:
			startInitialDialog()
		elif hasTalked && !hasFinished:
			startOnQuestDialog()
		else:
			startEndDialog()

func startInitialDialog() -> void:
	if initialDialog:
		initialDialog.play()

func startEndDialog() -> void:
	if endDialog:
		endDialog.play()

func startOnQuestDialog() -> void:
	if onQuestDialog:
		onQuestDialog.play()

func handleCustomLogic():
	pass


func _on_InitialDialog_dialogFinished() -> void:
	if !hasTalked:
		hasTalked = true
