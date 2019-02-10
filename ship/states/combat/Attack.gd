extends "res://ship/states/State.gd"

func update(delta):
	var target = owner._target.front().get_global_position()
	attack_from_distance(delta, target, 100.0)

func attack_from_distance(delta, target, distance):
	var ship_pos = owner.get_global_position()
	var distance_vector = target - ship_pos
	var distance_n = distance_vector.normalized()
	var d_v = distance_n * distance
	var distance_final = distance_vector - d_v
	var destination = ship_pos + distance_final
	var steering = owner.seek(ship_pos, destination, Vector2(0,0))
	owner.move_and_collide(steering * delta)