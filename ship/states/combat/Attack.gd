extends "res://ship/states/State.gd"

func update(delta):
	var vec = get_in_range(owner._target, 150.0)
	vec = vec.normalized() * owner._speed
	owner.move_and_slide(vec)

func get_in_range(target_array, optimal_fire_range : float) -> Vector2: 
	var pos = owner.get_global_position()
	var target_pos = target_array.front().get_global_position()
	var range_vector = Vector2(optimal_fire_range, 0)
	var angle_vector = target_pos.angle_to_point(pos)
	range_vector = range_vector.rotated(angle_vector)
	target_pos -= range_vector
	var rel_seek = owner.seek(pos, target_pos, owner._current_velocity)
	var rel_arrival = owner.arrival(pos, target_pos, rel_seek, owner._speed, owner._arrival_radius)
	return rel_arrival

func search_best_target(target_array: Array):
	var nearest_target = null
	for i in target_array:
		print(i)
	var dist_vector = owner.get_global_position()