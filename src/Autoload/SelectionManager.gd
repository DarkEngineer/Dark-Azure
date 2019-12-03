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

func filter_objects(object_array):
	#filtering objects...
	var duplicate_obj: Array
	
	for obj in object_array:
		if _objects.has(obj):
			duplicate_obj.append(obj)
	
	for obj in object_array:
		if not _objects.has(obj):
			add_object(obj)
		
