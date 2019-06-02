extends Area2D
class_name ShipBody

onready var animation = $Selection/Animation
onready var selection = $Selection

#movement variables
export var _thrust: float = 0.0 setget , get_thrust
var _acceleration: float = 10.0

var _arrival_radius = 100.0

#rotation variables
var _angular_velocity = 0.0
var _angular_acceleration = 20.0

#limit variables
var _max_thrust: float = 50.0
var _max_angular_velocity: float = 15.0

var _target = null
var _target_object = null

func _ready():
	randomize()
	

func _physics_process(delta):
	seek(get_global_mouse_position(), _acceleration, delta)


func seek(target, acceleration, delta):
	rotate_ship(target, delta)
	move_forward(target, acceleration, delta)

func thrust(c_thrust: float, c_angle: float) -> Vector2:
	var thruster = Vector2()
	thruster.x = cos(c_angle) * c_thrust
	thruster.y = sin(c_angle) * c_thrust
	
	return thruster

# function for forward movement
func move_forward(target_pos, c_acceleration, delta):
	apply_thrust(target_pos, c_acceleration, delta)
	var new_position = get_position() + thrust(get_thrust(), get_rotation()) * delta
	set_position(new_position)


func arrival(t_pos, pos, arrival_radius):
	var distance = (t_pos - pos).length()
	var limiter = 1.0
	if  distance <= arrival_radius:
		limiter = distance / arrival_radius
	return limiter

func apply_thrust(t_pos, c_acceleration, delta):
	var desired_thrust = create_desired_thrust(t_pos)
	var dv_dt = desired_thrust - get_thrust() 
	if dv_dt > 0.0:
		apply_accelerate(c_acceleration, delta)
	elif dv_dt <= 0.0:
		apply_accelerate(-c_acceleration, delta)

func apply_accelerate(c_acceleration, delta):
	_thrust += c_acceleration * delta
	_thrust = min(_thrust, _max_thrust)

#create desired thrust which is projected at ship_direction
func create_desired_thrust(t_pos) -> float:
	var desired_velocity = (t_pos - get_position()).normalized() * _max_thrust * arrival(t_pos, get_position(), _arrival_radius)
	var desired_direction = desired_velocity.normalized()
	var ship_direction = Vector2(1, 0).rotated(get_rotation())
	var desired_thrust_projection = desired_velocity.project(ship_direction)
	var dot = desired_direction.dot(ship_direction)
	if dot < 0.0:
		desired_thrust_projection = Vector2(0, 0)
	
	return desired_thrust_projection.length()


func rotate_ship(t_pos, delta):
	var direction = (t_pos - get_global_position()).normalized()
	var ship_direction = Vector2(1, 0).rotated(get_rotation())
	var dot = direction.dot(ship_direction)
	var cross = direction.cross(ship_direction)
	var angle = acos(dot)
	
	if angle > deg2rad(2.5):
		# to the left (-angle)
		if cross > 0.0:
			_angular_velocity -= deg2rad(_angular_acceleration) * delta
			_angular_velocity = max(_angular_velocity, -deg2rad(_max_angular_velocity))
		#to the right (+angle)
		elif cross < 0.0:
			_angular_velocity += deg2rad(_angular_acceleration) * delta
			_angular_velocity = min(_angular_velocity, deg2rad(_max_angular_velocity))
		
		rotate(_angular_velocity * delta)

func select_target(target_pos):
	_target = target_pos

func get_thrust():
	return _thrust

func reset_movement():
	_thrust = 0.0
	_angular_velocity = 0.0

func select():
	selection.show()

func deselect():
	selection.hide()

func start_selection_animation():
	animation.play("Selection")

func stop_selection_animation():
	animation.stop(true)

func _on_ShipBody_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_mouse"):
		selection.show()


func _on_Selection_draw():
	start_selection_animation()


func _on_Selection_hide():
	stop_selection_animation()

