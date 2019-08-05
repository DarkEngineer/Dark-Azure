extends Node

var _next_item_id: int = 0
var _next_character_id: int = 0

var _items_array = []

func _ready():
	pass

func get_item_by_id(id):
	for item in _items_array:
		if id == item.get_id():
			return id
	return printerr("No such item with ID - %d" % [id])