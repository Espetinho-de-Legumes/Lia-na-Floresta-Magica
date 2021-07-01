extends Area2D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use") && len(get_overlapping_bodies()) > 0:
		# print("Start Dialog")
		findAndUseDialogue()

func findAndUseDialogue() -> void:
	var dialog = get_node_or_null("DialogueSystem")
	
	if dialog:
		dialog.play()
