extends KinematicBody2D
class_name Ship

signal highlight()
signal move(target)
signal patrol()
signal attack(target)

var statistics = {
	"hull": 100.0,
	"hull_max": 100.0
}

var _target = null
var _wander_angle: float = 0.0
var _ANGLE_MAX: int = 10

var _max_speed: float = 40.0
var _max_rotation_speed: float = 10 # 10 degrees/s
var _arrival_radius = 150.0

export var _thrust_vector: Vector2 = Vector2(0, 0)
var _current_velocity := Vector2()

func _ready() -> void:
	connect("highlight", self, "_on_Ship_highlight")
	connect("move", self, "_on_move_to_target")
	connect("patrol", self, "_on_patrol_system")
	connect("attack", self, "_on_attack")

func _on_Ship_highlight():
	if not $Highlight.is_visible_in_tree():
		$Highlight.show()

func deselect():
	$Highlight.hide()

#project steering to thrust force vector
func generate_thrust_force(steering_force):
	var ship_rotation = $Shape.get_rotation()
	var thrust_vector = Vector2(1, 0)
	thrust_vector = thrust_vector.rotated(ship_rotation)
	var thrust_projection = steering_force.project(thrust_vector)
	var dot_product = thrust_projection.normalized().dot(thrust_vector)
	var t_dict = {
		"projection": thrust_projection,
		"dot_product": dot_product
	}
	return t_dict

#project steering to rotation force vector
func generate_steering_angle(steering_force):
	var ship_rotation = $Shape.get_rotation()
	var thrust_vector = Vector2(1, 0)
	thrust_vector = thrust_vector.rotated(ship_rotation)
	var steering_angle = thrust_vector.angle_to(steering_force)
	return rad2deg(steering_angle)

func rotate_shape(rotation):
	$Shape.rotate(deg2rad(rotation))


###########################################################################
# MOVEMENT FUNCTIONS
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
#

##############################################################################

func _on_move_to_target(target):
	_target = target["global"]
	$StateMachine._change_state("move")

func _on_patrol_system():
	$StateMachine._change_state("patrol")

func _on_attack(target):
	_target = target
	$StateMachine._change_state("attack")
