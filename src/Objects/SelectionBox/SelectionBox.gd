extends Area2D

var _properties = {
	"size": Vector2(0, 0),
	"start": Vector2(0, 0),
	"end": Vector2(0, 0)
}

var _started = false

onready var _c_shape = $CollisionShape

func _ready():
	set_process(false)

func _unhandled_input(event):
	if event.is_action_pressed("left_mouse"):
		_started = true
		_properties.start = get_global_mouse_position()
	if event.is_action_released("left_mouse"):
		show()
		_started = false
		_properties.end = get_global_mouse_position()
		set_shape_size(_properties.end)
		$Timer.start()


func set_shape_size(m_pos):
	var shape = _c_shape.get_shape()
	var current_mouse_position = m_pos
	var x_size = current_mouse_position.x - _properties.start.x
	var y_size = current_mouse_position.y - _properties.start.y
	var size = Vector2(x_size, y_size)
	_c_shape.set_global_position(_properties.start + size / 2.0)
	shape.set_extents(size / 2.0)


func _on_Timer_timeout():
	print(get_overlapping_bodies())
	hide()
