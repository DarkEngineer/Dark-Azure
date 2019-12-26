extends Control



func _ready():
# warning-ignore:return_value_discarded
	CommandMenuManager.connect("mouse_command_menu_triggered", self, "_on_mouse_command_menu_trigger")

func _on_mouse_command_menu_trigger(_data):
	$MouseCommandMenu.set_position(get_viewport().get_mouse_position())
	$MouseCommandMenu.popup()


