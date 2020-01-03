extends Node

var _objects = []

func _ready():
	pass

func _input(event):
	if not _objects.empty():
		event.is_action_pressed("right_mouse")

func add_object(obj):
	obj.select()
	_objects.append(obj)

func get_objects():
	return _objects

func clear():
	for obj in _objects:
		obj.unselect()
	_objects.clear()

func parse_objects(obj_array):
	for obj in obj_array:
		add_object(obj)
