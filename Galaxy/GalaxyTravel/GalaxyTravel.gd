extends Object
class_name GalaxyTravel

"""
Galaxy Travel class
Contains information about galaxy travel
"""

var _obj: Object setget , get_object
var _destination: Vector2

func _init(obj: Object, dest: Vector2):
	_obj = obj
	_destination = dest

func get_object():
	return _obj

func get_destination():
	return _destination