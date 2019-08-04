extends Object
class_name Building

var _name: String
var _inventory = []

func _init(n):
	_name = n

func add_inventory(i: Commodity, q: float):
	var i_obj = {
		"item": i,
		"quantity": q
	}
	if not add_to_stack(i, q):
		_inventory.append(i_obj)

func add_to_stack(i, q) -> bool:
	for obj in _get_inventory():
		if i == obj.item:
			var index = _inventory.find(obj)
			_inventory[index].quantity += q
			return true
	return false

func _get_inventory():
	return _inventory

func get_inventory():
	return _inventory.duplicate()