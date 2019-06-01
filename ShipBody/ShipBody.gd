extends Area2D
class_name ShipBody

onready var animation = $Selection/Animation
onready var selection = $Selection

var _thrust : float = 0.0
var _angular_velocity = 0.0
var _angular_acceleration = 20.0
var _max_angular_velocity : float = 10.0

func _ready():
	pass

func _physics_process(delta):
	rotate_ship(delta)

func thrust(c_thrust : float, c_angle : float) -> Vector2 :
	var thruster = Vector2()
	thruster.x = cos(c_angle) * c_thrust
	thruster.y = sin(c_angle) * c_thrust
	return thruster

func move_forward(c_thrust, c_angle, delta):
	var t_thrust = thrust(c_thrust, c_angle)
	var current_pos = get_position()
	var next_pos = current_pos + t_thrust * delta


func rotate_ship(delta):
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

