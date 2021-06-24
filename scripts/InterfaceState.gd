"""
Interface para todos os estados que um Character pode ter
"""
extends Node

signal finished(nextState)

var actor:KinematicBody2D = null

func setActor(actor: KinematicBody2D) -> void:
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

func get_name() -> String:
	return "State"
