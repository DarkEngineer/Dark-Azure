extends Area2D

var _id: int = -1
var _star_system = null

func set_star_system(value):
	_star_system = value

func get_star_system():
	return _star_system

func set_id(value):
	_id = value

func get_id() -> int:
	return _id


# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_Star_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_mouse"):
		global.emit_signal("changed_to_star_system", get_star_system())
