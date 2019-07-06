extends "res://PlanetTile/Field/Structure.gd"
class_name Building

export (int) var _building_time
export (Dictionary) var _building_cost

func get_building_time() -> int:
	# get structure building type
	return _building_time

func get_building_cost() -> Dictionary:
	# get structure building cost on the field
	return _building_cost