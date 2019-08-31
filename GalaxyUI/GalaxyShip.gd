extends Area2D

var _default_speed = 150
var _destination = null

var _selected = false

var _galaxy_ref = null

signal galaxy_ship_selected(ship)
signal galaxy_ship_deselected(ship)

func _ready():
	pass

func _physics_process(delta):
	if _destination != null:
		if _destination as Vector2:
			var new_pos = get_position() + move_to(_destination) * delta
			set_position(new_pos)

func set_galaxy_ref(g_ref):
	"""
	Set reference to galaxy object
	"""
	_galaxy_ref = g_ref
	set_signals_to_galaxy()

func set_signals_to_galaxy():
	var err_array = []
	err_array.append(connect("galaxy_ship_selected", _galaxy_ref, "_on_galaxy_ship_selected"))
	err_array.append(connect("galaxy_ship_deselected", _galaxy_ref, "_on_galaxy_ship_deselected"))
	if err_array.max() == 0:
		return true
	else:
		printerr(err_array)
		return false

func move_to(destination):
	var distance_vector = destination - get_position()
	var distance_norm = distance_vector.normalized()
	var speed_vector = distance_norm * _default_speed
	rotate_to_travel_path(speed_vector)
	return speed_vector

func rotate_to_travel_path(vector_norm: Vector2):
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
