extends Resource
class_name Structure

enum Building_Type {RESEARCH, INDUSTRY, MILITARY}

export (String) var _name
export (Building_Type) var _type
export (String) var _description

func get_building_name():
	return _name

func get_building_type():
	return _type

func get_building_description() -> String:
	return _description

func get_building_types():
	var _array = []
	for n in Building_Type:
		_array.append(n)
	return _array