extends Node
class_name State

signal finished

var actor: Node
var state_machine: StateMachine
var is_interrupt: bool = false

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass
