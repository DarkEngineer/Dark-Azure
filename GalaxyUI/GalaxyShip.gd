extends Area2D

var _default_speed = 150
var _destination = null

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("left_mouse"):
		_destination = get_global_mouse_position()

func _physics_process(delta):
	if _destination != null:
		if _destination as Vector2:
			var new_pos = get_position() + move_to(_destination) * delta
			set_position(new_pos)

func move_to(destination):
	var distance_vector = destination - get_position()
	var distance_norm = distance_vector.normalized()
	var speed_vector = distance_norm * _default_speed
	rotate_to_travel_path(speed_vector)
	return speed_vector

func rotate_to_travel_path(vector_norm: Vector2):
	var t_rot = get_rotation()
	var final_rotation = vector_norm.angle()
	var diff_rotation = final_rotation - t_rot
	rotate(diff_rotation)
	