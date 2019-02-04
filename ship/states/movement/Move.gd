extends "res://ship/states/State.gd"



func update(delta):
	var pos = owner.get_global_position()
	var steering = owner.seek(pos, owner._target, Vector2(0, 0))
	owner.generate_thrust_force(steering)
	owner.update()

