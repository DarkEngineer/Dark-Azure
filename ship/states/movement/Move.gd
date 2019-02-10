extends "res://ship/states/State.gd"

func update(delta):
	var ship_pos = owner.get_global_position()
	var target = owner._target
	var speed = owner._max_speed
	var arrival_r = owner._arrival_radius
	check_distance(ship_pos, target)
	move(delta, ship_pos, target, Vector2(0, 0), speed, arrival_r)

func move(delta, pos, target, velocity, c_speed, radius):
	var steering_force = owner.arrival(pos, target, velocity, c_speed, radius)
	var steer_n = steering_force.normalized()
	owner.move_and_collide(steer_n * c_speed * delta)

func check_distance(ship_pos, target_pos):
	var distance = target_pos - ship_pos
	if distance.length() < 5.0:
		emit_signal("finished", "previous")