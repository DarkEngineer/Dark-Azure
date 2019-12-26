extends PopupMenu

var commands = CommandMenuManager.get_command_list()

func _ready():
	pass

func create_command_signals(command_list):
	for com in commands:
		CommandMenuManager.create_command_signal(com.signal)


func _on_MouseCommandMenu_id_pressed(id):
	var _data = null
	for com in commands:
		if com.id == id:
			CommandMenuManager.emit_signal(com.signal, _data)
			break


func _on_MouseCommandMenu_about_to_show():
	clear()
	for com in commands:
		add_item(com.name, com.id)
