extends Area2D

var _details = {
	"top_left": Vector2(0, 0),
	"top_right": Vector2(0, 0),
	"bottom_left": Vector2(0, 0),
	"bottom_right": Vector2(0, 0),
	"width": 0,
	"height": 0
}

onready var _c_shape = $Shape
var _start_mouse_position: Vector2
var _select_started: bool = false

signal objects_selected(obj_array)

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("left_mouse"):
		on_action_press()
	if event.is_action_released("left_mouse"):
		on_action_release()

func on_action_press():
	if not _select_started:
		_start_mouse_position = get_global_mouse_position()
		_select_started = true
		

func on_action_release():
	_select_started = false
	var tl = _start_mouse_position
	var br = get_global_mouse_position()
	
	var tr = Vector2(br.x, tl.y)
	var bl = Vector2(tl.x, br.y)
	
	set_col_shape_corner_points(tl, tr, bl, br)
	
	set_center()
	set_shape_properties(_details.width, _details.height)
	

func find_center() -> Vector2:
	var width = _details.top_right.x - _details.top_left.x
	var height = _details.bottom_right.y - _details.top_left.y
	
	var center: Vector2 = Vector2(_details.top_left.x + width / 2.0, _details.top_left.y + height / 2.0)
	
	set_length_properties(width, height)
	
	return center

func set_center():
	set_area_position(find_center())

func set_area_position(pos: Vector2):
	set_position(pos)

func set_col_shape_corner_points(tl, tr, bl, br):
	_details.top_left = tl
	_details.top_right = tr
	_details.bottom_left = bl
	_details.bottom_right = br

func set_length_properties(w, h):
	_details.width = w
	_details.height = h

func set_shape_properties(w: float, h: float):
	var shape = _c_shape.get_shape()
	shape.set_extents(Vector2(w / 2.0, h / 2.0))