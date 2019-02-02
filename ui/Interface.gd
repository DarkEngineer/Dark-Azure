extends Control

var planet_selected = null

var ship_commands = {
	"move_here": {
		"id": 1,
		"command": "move",
		"parameters": ["point"]
		},
	"attack_target": {
		"id": 2,
		"command": "attack",
		"parameters": ["object"]
	},
	"create_fleet": {
		"id": 3,
		"command": "fleet_create",
		"parameters": ["object_array"]
	},
	"disband_fleet": {
		"id": 4,
		"command": "fleet_disband",
		"parameters": ["object_fleet"]
	},
	"patrol_system": {
		"id": 5,
		"command": "patrol_system"
	},
	"patrol_planet": {
		"id": 6,
		"command": "patrol_planet",
		"parameters": ["object_planet"]
	},
	"stop_action": {
		"id": 7,
		"command": "stop_action"
	},
	"capture_object": {
		"id": 8,
		"command": "capture",
		"parameters": ["object"]
	},
	"raid_planet": {
		"id": 9,
		"command": "raid_planet",
		"parameters": ["object_planet"]
	}
}

func _ready():
	global.connect("trigger_planet_panel", self, "_fill_planet_panel")
	global.connect("trigger_command_panel", self, "_command_panel")
	global.connect("trigget_target_command_panel", self, "_target_command_panel")

# Planet Panel functions
###########################################
func add_details_titles(itemlist):
	pass

func _get_details():
	var name = planet_selected._name
	var faction = planet_selected._owner
	var list = $PlanetPanel/TabContainer/Details/ItemList
	var t_p_name = "Planet Name: "
	var t_p_faction = "Faction: "
	if list.get_item_count() > 0:
		list.clear()
	if name != null:
		list.add_item(t_p_name + name)
	else:
		list.add_item(t_p_name + "Unnamed")
	if faction != null:
		list.add_item(t_p_faction + faction)
	else:
		list.add_item(t_p_faction + "None")

func add_storage_titles(itemlist):
	itemlist.add_item("Name")
	itemlist.add_item("Amount")
	itemlist.add_item("Owned By")

func _get_storage_items():
	var storage = planet_selected._storage
	var list = $PlanetPanel/TabContainer/Storage/ItemList
	if storage.size() > 0:
		add_storage_titles(list)
		for i in storage:
			list.add_item(i)
			list.add_item(str(storage[i]))
	else:
		if list.get_item_count() > 0:
			list.clear()
		list.add_item("No resources in storage")

func add_structure_titles(itemlist):
	itemlist.add_item("Structure Name")
	itemlist.add_item("Owned By")
	itemlist.add_item("Current Action")

func _get_structures_list():
	var structures = planet_selected._structures
	var list = $PlanetPanel/TabContainer/Structures/ItemList
	if not structures.empty():
		add_structure_titles(list)
		for i in structures:
			list.add_item(i)
	else:
		if list.get_item_count() > 0:
			list.clear()
		list.add_item("No structures")

func _get_structures_build_list():
	var menu = $PlanetPanel/TabContainer/Structures/MarginContainer/BuildButton
	var buildlist = planet_selected.StructureTypes
	if menu.get_item_count() > 0:
			menu.clear()
	for i in buildlist:
		menu.add_item(i)

func _fill_planet_panel(planet):
	planet_selected = planet
	$PlanetPanel.show()
	_get_storage_items()
	_get_structures_list()
	_get_structures_build_list()
	_get_details()
############################################
# Command Menu functions
############################################
func _command_panel(array, type, m_pos_array):
	_get_ship_command(array, type, m_pos_array)

func _target_command_panel(obj_array, obj_type, target_array, m_pos_array):
	_get_ship_target_command(obj_array, obj_type, target_array, m_pos_array)

func _get_ship_command(array, type, m_pos_array):
	var menu = $CommandMenu
	menu.set_position(m_pos_array["viewport"])
	menu.popup()
	if menu.get_item_count() == 0:
		for i in ship_commands:
			if ship_commands[i].has("parameters"):
				if not ship_commands[i]["parameters"].front().begins_with("object"):
					menu.add_item(i, ship_commands[i].id)
	menu.set_meta("ship_commands", ship_commands)
	menu.set_meta("m_pos_array", m_pos_array)

func _get_ship_target_command(obj_array, obj_type, target_array, m_pos_array):
	var t_menu = $TargetCommandMenu
	t_menu.set_position(m_pos_array["viewport"])
	t_menu.popup()
	if t_menu.get_child_count() != 0:
		t_menu.clear()
	for i in ship_commands:
		if ship_commands[i].has("parameters"):
			if ship_commands[i]["parameters"].front().begins_with("object"):
				t_menu.add_item(i, ship_commands[i].id)
	t_menu.set_meta("ship_commands", ship_commands)
	t_menu.set_meta("m_pos_array", m_pos_array)
	t_menu.set_meta("target_array", target_array)
	t_menu.set_meta("object_array", obj_array)

func _on_CommandMenu_id_pressed(ID):
	var menu = $CommandMenu
	var meta = menu.get_meta("ship_commands")
	var mouse_pos = menu.get_meta("m_pos_array")
	var command = null
	var param = null
	for i in meta:
		if meta[i].id == ID:
			command = meta[i].command
			if meta[i].has("parameters"):
				if meta[i].parameters.has("point"):
					param = mouse_pos
	for j in global._select_array:
		if param != null:
			j.emit_signal(command, param)
		else:
			j.emit_signal(command)
	menu.clear()

func _on_TargetCommandMenu_id_pressed(ID):
	var t_menu = $TargetCommandMenu
	var commands = t_menu.get_meta("ship_commands")
	var target_array = t_menu.get_meta("target_array")
	var object_array = t_menu.get_meta("object_array")
	var command = null
	var param = null
	for i in commands:
		if commands[i].id == ID:
			command = commands[i].command
			if commands[i].has("parameters"):
				param = commands[i].parameters
			break
	for j in object_array:
		j.emit_signal(command, target_array)
