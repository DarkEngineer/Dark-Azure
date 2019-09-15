extends Area2D

var _default_speed = 150

const DEFAULT_TRAVEL_ABORT_DISTANCE = 5.0

var _selected = false

var _galaxy_ref = null
var _galaxy_geometrics_ref = null

signal galaxy_ship_selected(ship_obj)
signal galaxy_ship_deselected(ship_obj)

signal galaxy_ship_started_travel(galaxy_travel_obj)
signal galaxy_ship_aborted_travel(galaxy_travel_obj)

enum SHIP_STATES {
	IDLE,
	MOVING
}

var _current_state = SHIP_STATES.IDLE

var _current_travel: GalaxyTravel

func _ready():
	pass

func _physics_process(delta):
	if _current_state == SHIP_STATES.MOVING:
		var travel_move_vector = create_travel_move_speed(_current_travel.get_destination(), 
				delta)
		set_position(get_position() + travel_move_vector * delta) 
		check_abort_travel_distance()

func set_galaxy_ref(g_ref):
	"""
	Set reference to galaxy object
	"""
	_galaxy_ref = g_ref
	set_signals_to_galaxy()

func set_galaxy_geometrics_ref(g_geo_ref):
	"""
	Set reference to galaxy geometrics object
	"""
	_galaxy_geometrics_ref = g_geo_ref
	set_signals_to_galaxy_geometrics()

func set_signals_to_galaxy():
	var err_array = []
	err_array.append(connect("galaxy_ship_selected", _galaxy_ref, "_on_galaxy_ship_selected"))
	err_array.append(connect("galaxy_ship_deselected", _galaxy_ref, "_on_galaxy_ship_deselected"))
	if err_array.max() == 0:
		return true
	else:
		printerr(err_array.max())
		return false

func set_signals_to_galaxy_geometrics():
	var err_array = []
	#signals to galaxy geometrics here
	err_array.append(connect("galaxy_ship_started_travel", _galaxy_geometrics_ref, "_on_galaxy_ship_started_travel"))
	err_array.append(connect("galaxy_ship_aborted_travel", _galaxy_geometrics_ref, "_on_galaxy_ship_aborted_travel"))
	if err_array.max() == 0:
		return true
	else:
		printerr(err_array.max())
		return false

#MOVEMENT Functions

func set_start_travel(destination):
	#Check if during galaxy travel
	check_if_currently_travelling()
	
	_current_state = SHIP_STATES.MOVING
	var travel = GalaxyTravel.new(self, destination)
	emit_signal("galaxy_ship_started_travel", travel)
	_current_travel = travel

func set_abort_travel():
	_current_state = SHIP_STATES.IDLE
	emit_signal("galaxy_ship_aborted_travel", _current_travel)
	_current_travel = null 

func check_abort_travel_distance():
	if (_current_travel.get_destination() - get_position()).length() <= DEFAULT_TRAVEL_ABORT_DISTANCE:
		set_abort_travel() 

func check_if_currently_travelling():
	if _current_state == SHIP_STATES.MOVING and _current_travel != null:
		set_abort_travel()

func create_travel_move_speed(destination, delta):
	var distance_vector = destination - get_position()
	var distance_norm = distance_vector.normalized()
	var speed_vector = distance_norm * _default_speed
	rotate_to_travel_path(speed_vector, delta)
	return speed_vector

func rotate_to_travel_path(vector_norm: Vector2, delta):
	var t_rot = get_rotation()
	var final_rotation = vector_norm.angle()
	var diff_rotation = final_rotation - t_rot
	rotate(diff_rotation)

func check_select():
	var c_1 = $SelectCircle1
	if _selected and not c_1.is_visible_in_tree():
		c_1.show()
	elif not _selected and c_1.is_visible_in_tree():
		c_1.hide()

func set_selected():
	_selected = true
	
	emit_signal("galaxy_ship_selected", self)
	check_select()

func set_deselected():
	_selected = false
	
	emit_signal("galaxy_ship_deselected", self)
	check_select()

#MOVEMENT Signals

func set_start_galaxy_travel(galaxy_travel: GalaxyTravel):
	emit_signal("galaxy_ship_started_travel", galaxy_travel)

func set_aborted_galaxy_travel(galaxy_travel: GalaxyTravel):
	emit_signal("galaxy_ship_aborted_travel", galaxy_travel)