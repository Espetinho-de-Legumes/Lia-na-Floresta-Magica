"""
Interface para todos os estados que um Character pode ter
"""
extends Node

signal finished(nextState)

var actor

func _init(actor) -> void:
	self.actor = actor

func enter() -> void:
	return

func exit() -> void:
	return

func handleInput(event: InputEvent) -> void:
	return

func update(delta: float) -> void:
	return

func physicsUpdate(delta: float) -> void:
	return
