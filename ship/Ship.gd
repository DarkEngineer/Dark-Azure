extends KinematicBody2D
class_name Ship

signal highlight()
signal move(target)
signal patrol()
signal attack(target)

#SPEED PID CONTROL SIGNALS
signal start_speed_calculation()
signal stop_speed_calculation()

var _target = null
var _wander_angle: float = 0.0
var _ANGLE_MAX: int = 10
export var _max_speed: float = 40.0
export var _current_speed: float = 0.0 # process variable for PID
export var _setpoint_speed: float = 0.0 # set point for PID
export var _thrust_vector: Vector2 = Vector2(0, 0)

var _inertia = {
	"K": [0.2],
	"T": [0.3],
	"u_t": [0.0],
	"y_t": [0.0],
	"dy": [0.0, 0.0]
}

func _ready() -> void:
	connect("highlight", self, "_on_Ship_highlight")
	connect("move", self, "_on_move_to_target")
	connect("patrol", self, "_on_patrol_system")
	connect("attack", self, "_on_attack")
	connect("start_speed_calculation", $SpeedPIDController, "_on_start_timer")
	connect("start_stop_calculation", $SpeedPIDController, "_on_stop_timer")
	get_speed_pid().get_timer().connect("timeout", self, "_on_speed_timeout")

func _draw():
	if _target != null:
		draw_line(Vector2(0, 0), _target - get_global_position(), ColorN("red"), 1)
		draw_line(Vector2(0, 0), Vector2(_current_speed, 0), ColorN("blue"), 2)

func _on_Ship_highlight():
	if not $Highlight.is_visible_in_tree():
		$Highlight.show()

func deselect():
	$Highlight.hide()

func get_speed_pid():
	return $SpeedPIDController

# SHIP INERTIA
func calculate_inertia(u_t):
	_inertia.u_t[0] = u_t
	var y_t = _inertia["K"][0] * _inertia["u_t"][0]
	y_t -= get_speed_pid()._dt / _inertia.T[0] * (_inertia.dy[0] - _inertia.dy[1])
	_inertia.y_t[0] = y_t
	_inertia.dy[1] = _inertia.dy[0]
	_inertia.dy[0] = _inertia.y_t[0]
	return y_t

# MOVEMENT FUNCTIONS
###########################################################################
func seek(pos, target, velocity) -> Vector2:
	var desired_velocity = target - pos 
	var steering = desired_velocity - velocity
	return steering

func flee(pos, target, velocity):
	var desired_velocity = pos - target
	var steering = desired_velocity - velocity
	return steering

func arrival(pos, target, velocity, c_speed, radius):
	var desired_velocity = target - pos
	var distance = desired_velocity.length()
	
	if distance < radius:
		desired_velocity = desired_velocity.normalized() * c_speed * (distance / radius)
	else:
		desired_velocity = desired_velocity.normalized() * c_speed
	
	var steering = desired_velocity - velocity
	
	return steering

func wander(pos, velocity_thrust, circle_distance, circle_radius):
	var circle_center = velocity_thrust.normalized()
	circle_center *= circle_distance
	var displacement = Vector2(0, -1)
	displacement *= circle_radius
	displacement = displacement.rotated(deg2rad(_wander_angle))
	
	var pos_neg_array = [1, -1]
	var value = randi() % pos_neg_array.size()
	_wander_angle += value * (randi() % _ANGLE_MAX - _ANGLE_MAX * 0.5)
	
	return circle_center + displacement 

func pursue(pos_pursuer, pos_target, velocity, target_velocity, max_target_speed):
	var distance = pos_target - pos_pursuer
	var T = distance.length() / max_target_speed
	var future_position = pos_target + target_velocity * T
	return seek(pos_pursuer, future_position, velocity)

func evade(pos, pos_target, velocity, target_velocity, max_target_speed):
	var distance = pos_target - pos
	var update_ahead = distance. length() / max_target_speed
	var future_position = pos_target + target_velocity * update_ahead
	return flee(pos, future_position, velocity)

###########################################################################
func _on_move_to_target(target):
	_target = target["global"]
	$StateMachine._change_state("move")
	emit_signal("start_speed_calculation")

func _on_patrol_system():
	$StateMachine._change_state("patrol")

func _on_attack(target):
	_target = target
	$StateMachine._change_state("attack")

func _on_speed_timeout():
	var u_t = get_speed_pid().calculate(_setpoint_speed, _current_speed)
	_current_speed = calculate_inertia(u_t)
	print(_current_speed)