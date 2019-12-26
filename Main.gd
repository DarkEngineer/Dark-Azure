extends Node2D

func _unhandled_input(event):
	if event.is_action_pressed("right_mouse"):
		CommandMenuManager.emit_signal("mouse_command_menu_triggered", {"test_data": -1})
