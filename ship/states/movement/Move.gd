extends "res://ship/states/State.gd"

func update(delta):
	if owner._target != null:
		if move_to_point(delta, owner._target) < 3.0:
			owner._target = null
			owner._current_velocity = Vector2(0, 0)
			emit_signal("finished", "previous")

func move_to_point(delta, target_pos):
	var steering = owner.seek(owner.get_global_position(), target_pos, Vector2(0, 0))
	var ship_vectors = owner.project_ship_vectors(steering)
	print(ship_vectors)
	return 0
