extends KinematicBody2D

var _velocity_vector = Vector2.ZERO

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("right_mouse"):
		$StateMachine.start_system_jump(get_global_mouse_position())

func select():
	$Select.show()

func unselect():
	$Select.hide()

