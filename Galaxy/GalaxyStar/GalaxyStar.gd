extends Area2D



var _star_system_id: int = -1

var _star_system = null setget set_star_system, get_star_system

func _ready():
	pass

func set_id(value: int) -> void:
	_star_system_id = value

func get_id() -> int:
	return _star_system_id

func set_star_system(value) -> void:
	_star_system = value

func get_star_system():
	return _star_system

