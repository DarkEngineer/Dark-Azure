extends Object
class_name BlueprintDependency

var _items = []

func add(n, q):
	var obj = {
		"name": n,
		"quantity": q
	}
	_items.append(obj)

func get_items():
	return _items.duplicate()