extends Node

enum SELECTION_TYPES {
	MOVING_OBJECT,
	STATIC_OBJECT
}

var _objects = []

func add_object(object):
	_objects.append(object)

func delete_object(object):
	_objects.erase(object)
