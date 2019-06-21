extends Node

var _index: Vector2 = Vector2(-1, -1) setget set_field_index, get_field_index

var _data = {
	"structure": null,
	"owner": null
} setget set_data, get_data

func _ready():
	pass

func set_field_index(index: Vector2):
	_index = index

func get_field_index() -> Vector2:
	return _index

func set_data(data: Dictionary) -> void:
	_data = data

func get_data() -> Dictionary:
	return _data

func set_structure(struct: Structure):
	get_data().structure = struct

func get_structure() -> Structure:
	return get_data().structure