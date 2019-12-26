extends Node


var _target = null setget set_target, get_target


func _ready():
	pass # Replace with function body.


func set_target(data):
	_target = data

func get_target():
	return _target

func filter_target(data):
	set_target(data)
