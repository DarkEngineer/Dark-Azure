extends KinematicBody2D

enum STATES {
	IDLE,
	MOVING
}

var _default_speed = 100.0
var _current_speed = 0.0

var _previous_state = null
var _current_state = null

var _target_details = {}
var _previous_target = {}

func _ready():
	pass

func _unhandled_input(event):
	if event.is_action_pressed("left_mouse"):
		teleport_to(get_global_mouse_position())

func move_to(dest_pos):
	var dist_vec = dest_pos - get_position()
	var dist_vec_norm = dist_vec.normalized()
	var vel_vector = dist_vec_norm * _default_speed
	move_and_collide(vel_vector)

func teleport_to(dest_pos):
	set_position(dest_pos)
