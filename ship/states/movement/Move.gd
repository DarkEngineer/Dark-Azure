extends "res://ship/states/State.gd"

func update(delta):
	if owner._target != null:
		if move_to_target(delta, owner._target) < 3.0:
			owner._target = null
			emit_signal("finished", "previous")

func move_to_target(delta, target_pos):
	var des_vel = target_pos - owner.get_global_position()
	var des_vel_norm = des_vel.normalized()
	var speed = 30.0
	owner._current_velocity = des_vel_norm * speed
	owner.move_and_slide(owner._current_velocity)
	owner.rotate_ship(owner._current_velocity)
	return des_vel.length()