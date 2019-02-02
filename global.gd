extends Node

var _select_array = []


# INTERFACE TRIGGERS
signal trigger_planet_panel(planet)
signal trigger_command_panel(obj_array, type, m_pos_array)
signal trigget_target_command_panel(obj_array, obj_type, target_array, m_pos_array)


# SELECTION SIGNALS
signal add_selection(obj)
signal clear_selection()
signal request_pointer_selection()

func _ready():
	connect("add_selection", self, "_select")
	connect("clear_selection", self, "_clear_select")

func _select(obj_array):
	emit_signal("clear_selection")
	for obj in obj_array:
		_select_array.append(obj)
		obj.emit_signal("highlight")

func _clear_select():
	var obj_array = _select_array.duplicate()
	for obj in obj_array:
		obj.deselect()
		_select_array.erase(obj)