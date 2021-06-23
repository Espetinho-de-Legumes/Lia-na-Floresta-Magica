"""
Esse script é a base da Máquina de Estado que usarei neste projeto.
Ele é responsável por inicializar, ativar ou desativar a Máquina de Estado,
delegar o _physics_process, chamadas de _inputs para os nós do Estado e
mudar de estado.

Baseado no livro: http://gameprogrammingpatterns.com/ 
E no exemplo do canal GDQuest: 
https://github.com/GDQuest/godot-demos/tree/master/2018/04-24-finite-state-machine/player_v2
"""
extends KinematicBody2D

signal state_changed(currentState)

export(Array, String, FILE, "*.gd") var listOfStates

var statesMap = {}
var currentState = null
var isActive = false setget setActive

func _ready() -> void:
	var i:int = 0
	var initialState: Node = null
	
	for state in listOfStates:
		var instanceOfState:Node = state.new(self)
		instanceOfState.connect("finished", self, "changeState")
		
		if i == 0:
			initialState = instanceOfState
		
		statesMap[instanceOfState.get_name()] = instanceOfState
		i += 1
	
	init(initialState)

func init(startState: Node) -> void:
	setActive(true)
	# currentState = get_node(startState)
	currentState.start()

func setActive(value: bool) -> void:
	isActive = value
	set_physics_process(value)
	set_process_input(value)
	
	if !isActive:
		currentState = null

func _unhandled_input(event: InputEvent) -> void:
	currentState.handleInput(event)

func _process(delta: float) -> void:
	currentState.update(delta)

func _physics_process(delta: float) -> void:
	currentState.physicsUpdate(delta)

func changeState(newState: String) -> void:
	if !isActive:
		return
	
	currentState.exit()
	currentState = statesMap[newState]
	emit_signal("state_changed", currentState)
	currentState.enter()
