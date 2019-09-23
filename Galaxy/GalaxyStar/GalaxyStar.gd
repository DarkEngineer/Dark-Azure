extends Area2D



var _star_system_id: int = -1

var _star_system = null setget set_star_system, get_star_system
var _mouse_inside = false

func _ready():
	pass

func set_id(value: int) -> void:
	_star_system_id = value

func get_id() -> int:
	return _star_system_id

func set_star_system(value) -> void:
	_star_system = value

func get_star_system():
	return _star_system



func _on_GalaxyStar_mouse_entered():
	if not _mouse_inside:
		_mouse_inside = true

func _on_GalaxyStar_mouse_exited():
	if _mouse_inside:
		_mouse_inside = false

func _on_GalaxyStar_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_mouse"):
		global.emit_signal("galaxy_star_picked", self)
		_mouse_inside = false


func _on_GalaxyStar_visibility_changed():
	if is_visible_in_tree():
		show()
	else:
		hide()
