extends Object
class_name DA_Item

var _name: String = "Default Item 01" setget , get_name
var _name_id: String = "default_item"
var _id: int = 0 setget , get_id

func _init(name, name_id):
	_name = name
	_name_id = name_id
	_id = get_next_item_id()

func get_next_item_id():
	var id = global._next_item_id
	global._next_item_id += 1
	return id

func get_name():
	return _name

func get_id():
	return _id