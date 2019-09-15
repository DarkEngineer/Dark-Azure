class_name GalaxyTravel

"""
Galaxy Travel class
Contains information about galaxy travel
"""

var _obj: Object setget , get_object
var _destination

func _init(obj: Object, dest):
	_obj = obj
	_destination = dest

func get_object():
	return _obj

func get_destination():
	return _destination