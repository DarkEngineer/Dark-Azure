extends "res://ship/states/State.gd"

func update(delta):
	if owner._target != null:
		if move_to_point(delta, owner._target) < 3.0:
			owner._target = null
			emit_signal("finished", "previous")

func move_to_point(delta, target_pos):
	var ship_pos = owner.get_global_position()
	var vel = owner._current_velocity
	var steering = owner.seek(ship_pos, target_pos, vel)
	
	owner.move_and_slide(steering)
	
	return (target_pos - ship_pos).length()