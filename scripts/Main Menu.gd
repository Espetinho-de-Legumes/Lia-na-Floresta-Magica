extends Control


func _ready():
	pass


func _on_Jogar_pressed():
	var ERROR = get_tree().change_scene("res://scenes/Level 1.tscn")
	
	if ERROR != OK:
		print(ERROR)


func _on_Sair_pressed():
	get_tree().quit()
