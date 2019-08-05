extends Object
class_name DA_Item

var _name: String = "default_item"
var _id: int = 0
var _owner_id: int = 0
var _quantity: float = 0

func _init(name, owner_id = 0, quantity = 1):
	_name = name
	_owner_id = owner_id
	_id = get_next_item_id()

func get_next_item_id():
	var id = global._next_item_id
	global._next_item_id += 1
	return id