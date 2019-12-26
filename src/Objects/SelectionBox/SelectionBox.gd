extends Area2D

enum SELECT_BOX_TYPE {
	SELECT, #left mouse
	TARGET #right mouse
}

var _properties = {
	"size": Vector2(0, 0),
	"start": Vector2(0, 0),
	"end": Vector2(0, 0)
}

var _started = false
export (SELECT_BOX_TYPE) var _box_type

onready var _c_shape = $CollisionShape

func _ready():
	set_process(false)

func _unhandled_input(event):
	match _box_type:
		SELECT_BOX_TYPE.SELECT:
			if event.is_action_pressed("left_mouse"):
				_started = true
				_properties.start = get_global_mouse_position()
			if event.is_action_released("left_mouse"):
				show()
				_started = false
				_properties.end = get_global_mouse_position()
				set_shape_size(_properties.end)
				$Timer.start()
		SELECT_BOX_TYPE.TARGET:
			if event.is_action_pressed("right_mouse"):
				_started = true
				_properties.start = get_global_mouse_position()


func set_shape_size(m_pos):
	var shape = _c_shape.get_shape()
	var current_mouse_position = m_pos
	var x_size = current_mouse_position.x - _properties.start.x
	var y_size = current_mouse_position.y - _properties.start.y
	var size = Vector2(x_size, y_size)
	_c_shape.set_global_position(_properties.start + size / 2.0)
	shape.set_extents(size / 2.0)


func _on_Timer_timeout():
	match _box_type:
		SELECT_BOX_TYPE.SELECT:
			SelectionManager.filter_objects(get_overlapping_bodies())
		SELECT_BOX_TYPE.TARGET:
			var object_holder = []
			for obj in get_overlapping_areas():
				object_holder.append(obj)
			for obj in get_overlapping_bodies():
				object_holder.append(obj)
				
			TargetManager.filter_target({
				"target_mouse_position": _properties.start, 
				"target_objects": object_holder
				})
	hide()
