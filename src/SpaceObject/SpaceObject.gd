extends KinematicBody2D


var _acceleration = 50.0
var _speed = 0.0
var _velocity = Vector2.ZERO

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("right_mouse"):
		$StateMachine.start_system_jump(get_global_mouse_position())

func select():
	$Select.show()

func unselect():
	$Select.hide()

func reset_velocity():
	_speed = 0
	_velocity = Vector2.ZERO
