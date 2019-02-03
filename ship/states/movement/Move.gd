extends "res://ship/states/State.gd"

onready var speed_pid = owner.get_speed_pid()
var speed = 0.0

func update(delta):
	var pos = owner.get_global_position()
	var steering = owner.seek(pos, owner._target, Vector2(0, 0))
	manage_speed((owner._target - pos).length())
	owner.move_and_slide(steering.normalized() * owner._current_speed)
	owner.update()

func check_distance(distance):
	if distance < 0.25 * owner._max_speed:
		owner._target = null
		owner.emit_signal("stop_speed_calculation")
		emit_signal("finished", "previous")

func manage_speed(distance):
	var speed: float = 0.0
	if distance > 10 * owner._max_speed:
		speed = owner._max_speed
	elif distance > 5 * owner._max_speed and distance < 10 * owner._max_speed:
		speed = owner._max_speed * 0.5
	elif distance < 5 * owner._max_speed and distance > 1.5 * owner._max_speed:
		speed = owner._max_speed * 0.25
	elif distance < 1.5 * owner._max_speed:
		speed = owner._max_speed * 0.2
	elif distance < 5.0:
		speed = 0.0
	owner._setpoint_speed = speed

func exit():
	print("EXIT")
	owner._setpoint_speed = 0.0
	owner._current_speed = 0.0
	speed_pid.reset_integral()