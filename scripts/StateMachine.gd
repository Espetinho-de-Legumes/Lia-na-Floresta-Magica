"""
Esse script é a base da Máquina de Estado que usarei neste projeto.
Ele é responsável por inicializar, ativar ou desativar a Máquina de Estado,
delegar o _physics_process, chamadas de _inputs para os nós do Estado e
mudar de estado.

Baseado no livro: http://gameprogrammingpatterns.com/ 
E no exemplo do canal GDQuest: 
https://github.com/GDQuest/godot-demos/tree/master/2018/04-24-finite-state-machine/player_v2
"""
extends Node
class_name StateMachine

# signal state_changed(currentState)

# export(Array, String, FILE, "*gd") var listOfStates setget setList

var statesMap = {}
var currentState:Node = null
var isActive:bool = false setget setActive
# var listOfStates = []

func init(actor: KinematicBody2D, listOfStates: Array) -> void:
	var i:int = 0
	var initialState = null
	print(listOfStates)
	
	for state in listOfStates:
		var instanceOfState:InterfaceState = load(state).new()
		instanceOfState.setActor(actor)
		instanceOfState.connect("finished", self, "changeState")
		
		if i == 0:
			initialState = instanceOfState
		
		statesMap[instanceOfState.get_name()] = instanceOfState
		i += 1
	
	setActive(true)
	currentState = initialState
	currentState.enter()

func setActive(value: bool) -> void:
	isActive = value
	set_physics_process(value)
	set_process_input(value)
	
	if !isActive:
		currentState = null

func changeState(newState: String) -> void:
	if !isActive || currentState.get_name() == newState:
		return
	
	currentState.exit()
	currentState = statesMap[newState]
	# emit_signal("state_changed", currentState)
	currentState.enter()
