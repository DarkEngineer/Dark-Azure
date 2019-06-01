extends Area2D
class_name ShipBody

onready var animation = $Selection/Animation
onready var selection = $Selection

#movement variables
export var _thrust: float = 0.0 setget , get_thrust
var _acceleration: float = 5.0

#rotation variables
var _angular_velocity = 0.0
var _angular_acceleration = 20.0

#limit variables
var _max_thrust: float = 20.0
var _max_angular_velocity: float = 10.0

var _target = null

func _ready():
	pass

func _physics_process(delta):
	if _target is Vector2:
		seek(_target, _acceleration, delta)

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
	accelerate(c_acceleration, delta)
	var limiter = create_thrust_limiter(target_pos)
	var new_position = get_position() + thrust(get_thrust(), get_rotation()) * delta * limiter
	set_position(new_position)

func check_arrival(t_pos, pos):
	var dist = t_pos - pos
	var arrival_dist = 5.0
	dist = dist.length()
	if dist <= arrival_dist:
		_target = null

func accelerate(c_acceleration, delta):
	_thrust += c_acceleration * delta
	_thrust = min(_thrust, _max_thrust)

#add limiter to thrust
func create_thrust_limiter(t_pos) -> float:
	var distance_v = t_pos - get_global_position()
	var direction = distance_v.normalized()
	var distance = distance_v.length()
	var ship_direction = Vector2(1, 0).rotated(get_rotation())
	var dot = direction.dot(ship_direction)
	var arrival = 1.0
	var slowing_radius = 50.0
	
	if distance <= slowing_radius:
		 arrival = distance / slowing_radius
		
	dot = max(0.0, dot)
	
	return dot * arrival

func rotate_ship(t_pos, delta):
	var direction = (get_global_mouse_position() - get_global_position()).normalized()
	var ship_direction = Vector2(1, 0).rotated(get_rotation())
	var dot = direction.dot(ship_direction)
	var cross = direction.cross(ship_direction)
	var angle = acos(dot)
	print(rad2deg(angle))
	
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

func get_thrust():
	return _thrust

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

