extends StaticBody2D

var _mineral_list_file_path = "res://data/minerals/minerals.json"

var _name: String = "Object 1"

var _minerals = []

func _ready():
	pass

func generate_minerals():
	var minerals = global.load_JSON_file(_mineral_list_file_path)
	
	for m in minerals.mineral_list:
		_minerals.append({"id": m.id, "name": m.name, "rarity": m.rarity, "resource_access": randi() % 101})




func _on_CelestialBody_mouse_entered():
	var obj_data = {"name": _name, "faction": "none"}
	InterfaceManager.emit_signal("tooltip_requested", obj_data)


func _on_CelestialBody_mouse_exited():
	InterfaceManager.emit_signal("tooltip_hidden")
