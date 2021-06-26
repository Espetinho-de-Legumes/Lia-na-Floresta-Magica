extends CanvasLayer

func _ready() -> void:
	setVisible(false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var newPauseState = !get_tree().paused
		
		get_tree().paused = newPauseState
		setVisible(newPauseState)


func _on_Voltar_ao_Jogo_pressed() -> void:
	get_tree().paused = false
	setVisible(false)

func setVisible(isVisible:bool) -> void:
	for node in get_children():
		node.visible = isVisible
