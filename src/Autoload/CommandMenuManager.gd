extends Node


signal mouse_command_menu_triggered(data)

var _commands = [
	{"id": 1, "name": "Move To %s", "signal": "selected_move_to_target", "connected_function": "_on_move_to_target_requested"},
] setget , get_command_list

func _ready():
	for com in get_command_list():
		create_command_signal(com.signal)
		connect_signal_to_function(com.signal, com.connected_function)

#function for creating signals from command list
func create_command_signal(signal_name):
	add_user_signal(signal_name)

func connect_signal_to_function(signal_name: String, function_name: String):
	self.connect(signal_name, self, function_name)

func get_command_list():
	return _commands.duplicate()

func _on_move_to_target_requested(_data):
	var selected_objects = SelectionManager.get_selected_objects()
	print("Selected objects move to target: %s" % [str(selected_objects)])
	for obj in selected_objects:
		if obj.is_in_group("Moving Objects"):
			obj.start_move(TargetManager.get_target().target_mouse_position)
