extends Node

enum SELECT_MODE {
	SINGLE,
	MULTIPLE
}

var _objects = [] setget , get_selected_objects

func add_object(object):
	_objects.append(object)

func delete_object(object):
	_objects.erase(object)

func get_selected_objects():
	return _objects.duplicate()

func filter_objects(selected_objects_array: Array, selection_mode = SELECT_MODE.MULTIPLE):
	#filtering objects...
	#array with objects already selected which are in current selection
	var selection_duplicate_array: Array
	var select_array: Array
	var unselect_array: Array
	
	match selection_mode:
		SELECT_MODE.SINGLE:
			_objects.clear()
			
		SELECT_MODE.MULTIPLE:
			#select duplicates and append to array
			for obj in selected_objects_array:
				if _objects.has(obj):
					selection_duplicate_array.append(obj)
				else:
					select_array.append(obj)
			
			#mark objects to deselection
			for obj in _objects:
				if not selected_objects_array.has(obj):
					unselect_array.append(obj)
			
			#remove not selected objects
			remove_unselected(unselect_array)
			
			for obj in select_array:
				add_object(obj)

func remove_unselected(obj_array):
	for obj in obj_array:
		delete_object(obj)
