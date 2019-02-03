extends "res://ship/states/State.gd"

func update(delta):
	owner.handle_move(delta, owner.get_global_position(), owner._target, owner._current_velocity)

