extends Control


func _ready():
	GlobalAudioManager.setAudio("MenuTheme")


func startGame():
	var ERROR = get_tree().change_scene("res://scenes/Levels/Level1.tscn")
	
	if ERROR != OK:
		print("ERROR")


func _on_Sair_pressed():
	get_tree().quit()


func _on_LIA_pressed() -> void:
	startGame()
