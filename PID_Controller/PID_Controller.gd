extends Node
class_name PID_Controller

var _prev_error: float = 0.0
var _integral: float = 0.0
var _int_max = 200
var _Kp: float = 0.01
var _Ki: float = 2
var _Kd: float = 0
var _dt = 0.01


func _ready():
	pass

func calculate(setpoint, pv):
	var error = setpoint - pv
	var Pout = _Kp * error
	
	_integral += error * _dt
	var Iout = _Ki * _integral
	
	var derivative = (error - _prev_error) / _dt
	var Dout = _Kd * derivative
	
	var output = Pout + Iout + Dout
	
	if _integral > _int_max:
		_integral = _int_max
	elif _integral < -_int_max:
		_integral = -_int_max
	_prev_error = error
	return output

func _on_Button_pressed():
	$IterationTimer.start()
