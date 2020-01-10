extends "res://src/StateMachine/State.gd"

enum {
	INIT,
	JUMP,
	ARRIVAL
}

var _jump_target = null

var start_jump = false
var end_rotation = false

var jump_status = INIT

const SLOW_RADIUS = 1000.0
const ROTATION_ERROR_TOLERANCE = 0.5

func update(delta):
	match jump_status:
		INIT:
			if not start_jump:
				if not end_rotation:
					rotate_to_destination(delta, _jump_target)
				else:
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

func system_jump_speed(_delta, jump_speed = 8000.0):
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
	

func rotate_to_destination(delta, direction_vector: Vector2):
	var angle_to_target = owner.get_angle_to_direction(direction_vector.normalized())
	print(angle_to_target)
	var mult = sign(angle_to_target) # sign function for distinguishing negative or positive rotation is needed
	if abs(angle_to_target) >= deg2rad(ROTATION_ERROR_TOLERANCE):
		owner.rotate(mult * deg2rad(owner._rotation_speed) * delta)
	else:
		end_rotation = true

func finish_arrival():
	start_jump = false
	end_rotation = false
	owner.reset_velocity()
	_jump_target = null
	emit_signal("finished", "previous")

func exit():
	start_jump = false
	end_rotation = false
	owner.reset_velocity()
	_jump_target = null
	jump_status = INIT

