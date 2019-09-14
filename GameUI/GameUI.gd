extends Control

onready var _c_menu = $CommandMenu

var _target = null

func _ready():
	set_signals_connection()

func set_signals_connection():
	global.connect("target_mouse_selected", self, "_on_target_selected")

func _on_target_selected(obj = null):
	var m_pos = get_viewport().get_mouse_position()
	_c_menu.clear()
	_target = obj
	if obj is Node:
		filter_menu_options(obj, _c_menu)
	else:
		default_menu_options()
	_c_menu.set_position(m_pos)
	_c_menu.popup()

func filter_menu_options(target, command_menu):
	if target.is_in_group("Galaxy Stars"):
		add_command_option("Travel to", 1, target.get_name())

func default_menu_options():
	add_command_option("Travel Here")

func add_command_option(command: String, command_id: int = -1, target_name: String = ""):
	if not target_name.empty():
		_c_menu.add_item("%s %s" % [command, target_name])
	else:
		_c_menu.add_item("%s" % [command])

func clear_target():
	_target = null

func _on_CommandMenu_id_pressed(ID):
	match ID:
		1:
			global.emit_signal("objects_to_target_moved", _target)
		_:
			pass
	clear_target()