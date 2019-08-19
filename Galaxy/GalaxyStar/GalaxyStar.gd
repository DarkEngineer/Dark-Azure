extends Area2D

var _star_system_id: int = -1

func _ready():
	pass

func set_id(value: int):
	_star_system_id = value

func get_id() -> int:
	return _star_system_id