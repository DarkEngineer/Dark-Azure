extends "res://ship/states/State.gd"

func update(delta):
	var pos = owner.get_global_position()
	var steering = owner.seek(pos, owner._target, Vector2(0, 0))
	var thrust_force = owner.generate_thrust_force(steering)
	var rotation_force = owner.generate_rotation_force(steering)
	thrust_and_rotate(thrust_force, rotation_force)
	owner.update()

func thrust_and_rotate(thrust_force, rotation_force):
	pass
