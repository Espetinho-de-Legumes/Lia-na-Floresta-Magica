extends Area2D

onready var initialDialog = get_node_or_null("InitialDialog")
onready var endDialog = get_node_or_null("EndDialog")

var hasTalked = false
var quantitiesOfWormsToFinishQuest = 15
var listOfOverlappedBodies

func _ready():
	if initialDialog:
		initialDialog.connect("dialogFinished", self, "_on_InitialDialog_dialogFinished")

func _input(event: InputEvent) -> void:
	listOfOverlappedBodies = get_overlapping_bodies()
	
	if event.is_action_pressed("use") && len(listOfOverlappedBodies) > 0:
		if !hasTalked:
			startInitialDialog()
		else:
			startEndDialog()
		
		handleCustomLogic()

func startInitialDialog() -> void:
	if initialDialog:
		initialDialog.play()

func startEndDialog() -> void:
	if endDialog:
		endDialog.play()

func handleCustomLogic():
	pass


func _on_InitialDialog_dialogFinished() -> void:
	if !hasTalked:
		hasTalked = true
