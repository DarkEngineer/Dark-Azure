extends KinematicBody2D


var _acceleration = 50.0
var _speed = 0.0
var _velocity = Vector2.ZERO

var _rotation_speed = 20.0 # rotate deg/s

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("right_mouse"):
		get_angle_to_direction(get_global_mouse_position())
		#$StateMachine.start_system_jump(get_global_mouse_position())

func select():
	$Select.show()

func unselect():
	$Select.hide()

func reset_velocity():
	_speed = 0
	_velocity = Vector2.ZERO

func get_angle_to_direction(direction_vector: Vector2):
	var obj_vector = Vector2.RIGHT.rotated(get_rotation())
	var distinction = obj_vector.angle_to(direction_vector)
	print("Diff: ", rad2deg(distinction))
