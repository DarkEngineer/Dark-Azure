extends Object
class_name DA_Item

var _name: String = "default_item" setget , get_name
var _id: int = 0 setget , get_id

func _init(name, owner_id = 0):
	_name = name
	_id = get_next_item_id()

func get_next_item_id():
	var id = global._next_item_id
	global._next_item_id += 1
	return id

func get_name():
	return _name

func get_id():
	return _id