extends "res://src/StateMachine/State.gd"

func enter():
	set_physics_process(false)

func exit():
	set_physics_process(true)
