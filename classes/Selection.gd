extends Area2D

var _multiselect = false
var _drag_start = Vector2(0, 0)
var _drag_size = Vector2(0, 0)
var _default_size = Vector2(10, 10)
var _default_vector = Vector2(0, 0)

func _ready():
	pass

func _unhandled_input(event):
	if event.is_action_pressed("left_mouse"):
		_multiselect = true
		_drag_start = get_global_mouse_position()
	if event.is_action_released("left_mouse"):
		_multiselect = false
		get_selection()
		set_shape_extents(_default_size)

func _process(delta):
	resize_shape()
	_set_position()

func _set_position():
	if not _multiselect:
		set_global_position(get_global_mouse_position() + _default_size)
	elif _multiselect:
		set_global_position(_drag_start + _drag_size / 2.0)

func get_selection():
	var bodies = get_overlapping_bodies()
	global.emit_signal("add_selection", bodies)

func resize_shape():
	if _multiselect:
		var pos = get_global_mouse_position()
		_drag_size = pos - _drag_start
		if _drag_size.length() < _default_size.length():
			_drag_size = _default_size * 2.0
		set_shape_extents(_drag_size / 2.0)

func set_shape_extents(size):
	var shape = $Collision.get_shape()
	shape.set_extents(size)