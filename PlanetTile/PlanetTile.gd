extends Node

var field_node = preload("res://PlanetTile/Field/Field.tscn")

var _data = {
	"coord": Vector2(-1, -1),
	"tile_size": {
		"x": -1,
		"y": -1
	},
	"owner": null
} setget set_data, get_data

func _ready():
	for i in range(2):
		for j in range(2):
			add_field(Vector2(i, j))

func set_data(data: Dictionary) -> void:
	_data = data

func get_data() -> Dictionary:
	return _data

func set_planet_tile_coord(coord: Vector2 = Vector2(0, 0)):
	_data.coord.x = coord.x
	_data.coord.y = coord.y

func add_field(index: Vector2):
	var field = field_node.instance()
	field.set_name("field_%d_%d" % [index.x, index.y])
	field.set_field_index(index)
	add_child(field)
