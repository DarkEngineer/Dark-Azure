extends "res://src/StateMachine/State.gd"

var _target_position

const ARRIVAL_DISTANCE = 10
const SYSTEM_JUMP_SPEED = 800

enum JUMP_STATES {
	ACCELERATE,
	JUMP,
	ARRIVAL
}

var jump_status

func enter():
	jump_status = JUMP_STATES.ACCELERATE

func initialize(target_pos):
	_target_position = target_pos

func update(delta):
	var start_pos = owner.get_global_position()
	owner._velocity_vector = Steering.arrive_to(owner._velocity_vector, start_pos, _target_position)
	owner.move_and_collide(owner._velocity_vector * delta)

func check_distance(space_pos: Vector2, target_pos: Vector2):
	var distance_vector = space_pos.distance_to(target_pos)
	if distance_vector.length() < 10:
		emit_signal("finished", "previous")

func start_accelerate():
	
