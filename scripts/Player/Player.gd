extends "res://scripts/StateMachine.gd"

onready var animationTree: AnimationTree = get_node("AnimationTree")
onready var sprite: Sprite = get_node("Sprite")

export (float) var maxSpeed = 340.0
export (float) var acceleration = 35.0
export (float) var friction = -20.0
export (float) var gravity = 2600.0 # pixel/sec
export (float) var jumpForce = -500.0
export (float) var jumpSustain = 220.0 # milisegundos
