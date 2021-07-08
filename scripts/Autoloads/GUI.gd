extends CanvasLayer

onready var PauseScene: Control = get_node("PauseScene")
onready var UserInterface: Control = get_node("UserInterface")

onready var ContadorGems = get_node("UserInterface/items_missoes/gems/contador")
onready var ContadorWorms = get_node("UserInterface/items_missoes/worms/contador")
onready var ContadorGlasses = get_node("UserInterface/items_missoes/contador_glasses")

var gems = -1
var worms = -1
var glasses = -1
var listOfExecptionsScenes = ["MainMenu", "GameOverScene"]

func _ready() -> void:
	PlayerData.connect("update_gui", self, "on_update_gui")
	
	verifiyGUIVisibilityForCurrentScene()
	
	setPauseSceneVisible(false)
	on_update_gui()

func _input(event: InputEvent) -> void:
	if listOfExecptionsScenes.has(PlayerData.currentLevel):
		return
	
	if event.is_action_pressed("pause"):
		var newPauseState = !get_tree().paused
		
		get_tree().paused = newPauseState
		setPauseSceneVisible(newPauseState)

func verifiyGUIVisibilityForCurrentScene() -> void:
	if listOfExecptionsScenes.has(PlayerData.currentLevel):
		setUserInterfaceVisible(false)
	else:
		setUserInterfaceVisible(true)

func on_update_gui() -> void:
	if gems != PlayerData.gems:
		gems = PlayerData.gems
		ContadorGems.text = "x%s" % gems
	
	if worms != PlayerData.collectedWorms:
		worms = PlayerData.collectedWorms
		ContadorWorms.text = "x %s" % worms
	
	if PlayerData.hasGlasses:
		glasses = 1
	else:
		glasses = 0
		
		ContadorGlasses.text = "x%s" % glasses

func _on_Voltar_ao_Jogo_pressed() -> void:
	get_tree().paused = false
	setPauseSceneVisible(false)

func setPauseSceneVisible(isVisible:bool) -> void:
	PauseScene.visible = isVisible

func setUserInterfaceVisible(isVisible:bool) -> void:
	UserInterface.visible = isVisible

func _on_Sair_pressed():
	get_tree().quit()
