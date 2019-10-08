extends Area2D
class_name SpaceObject

var _id: int = -1 setget set_id, get_id

func _ready():
	pass

func set_id(value):
	_id = value

func get_id():
	return _id

