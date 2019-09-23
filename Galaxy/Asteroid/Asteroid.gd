extends Area2D

var _asteroid_system_id: int setget set_id

func _ready():
	pass

func set_id(value: int) -> void:
	_asteroid_system_id = value
