extends "res://src/StateMachine/State.gd"

enum {
	INIT,
	JUMP,
	ARRIVAL
}

var _jump_target = null

var start_jump = false

var jump_status = INIT

const SLOW_RADIUS = 1000.0

func update(delta):
	match jump_status:
		INIT:
			if not start_jump:
				accelerate(delta)
			else:
				system_jump_speed(delta)
			var v = Steering.seek(get_velocity(), owner.get_global_position(), _jump_target, get_speed())
			owner.move_and_collide(v * delta)
		JUMP:
			move(delta)
		ARRIVAL:
			finish_arrival()

func set_jump_target(pos):
	_jump_target = pos
	jump_status = INIT

func get_object_speed():
	return owner._current_speed

func get_speed() -> float:
	return owner._speed

func get_acceleration() -> float:
	return owner._acceleration

func get_velocity() -> Vector2:
	return owner._velocity

func accelerate(delta, max_speed = 150.0):
	if get_speed() < max_speed:
		owner._speed += get_acceleration() * delta
	else:
		start_jump = true

func system_jump_speed(delta, jump_speed = 8000.0):
	owner._speed = jump_speed
	jump_status = JUMP

func check_distance(start_pos, end_pos):
	var distance = start_pos.distance_to(end_pos)
	return distance

func move(delta):
	if check_distance(owner.get_global_position(), _jump_target) <= 10.0:
		jump_status = ARRIVAL
	owner._velocity = Steering.arrive_to(owner._velocity, owner.get_global_position(), 
			_jump_target, get_speed(), SLOW_RADIUS)
	owner.move_and_collide(get_velocity() * delta)
	

func finish_arrival():
	start_jump = false
	owner.reset_velocity()
	emit_signal("finished", "previous")

