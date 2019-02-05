extends "res://ship/states/State.gd"

func update(delta):
	var pos = owner.get_global_position()
	var steering = owner.seek(pos, owner._target, Vector2(0, 0))
	var thrust_force = owner.generate_thrust_force(steering)
	var rotation_force = owner.generate_rotation_force(steering)
	thrust_and_rotate(delta, thrust_force, rotation_force)
	owner.update()

func thrust_and_rotate(delta, thrust, rotation):
	var thrust_force: Vector2
	if thrust.length() > owner._max_thrust_force:
		thrust_force = thrust.clamped(owner._max_thrust_force)
	else:
		thrust_force = thrust
	var ratio: float = thrust_force.length() / owner._max_thrust_force
	print(ratio)
	var thrust_speed = owner._max_speed * ratio
	owner.move_and_collide(thrust_force.normalized() * thrust_speed * delta)
