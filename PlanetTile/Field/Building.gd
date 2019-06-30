extends "res://PlanetTile/Field/Structure.gd"
class_name Building

export (int) var _building_time
export (Dictionary) var _building_cost

func get_building_time() -> int:
	return _building_time

func get_building_cost() -> Dictionary:
	return _building_cost