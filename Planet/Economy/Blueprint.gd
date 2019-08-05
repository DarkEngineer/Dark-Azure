extends Object
class_name Blueprint

var _commodity: Commodity
var _dependency: BlueprintDependency
var _quantity: float = 1
var _time: float = 0.0

func _init(n: String, q: float, d: BlueprintDependency):
	_commodity = Commodity.new(n)
	_quantity = q
	_dependency = d

func get_dependency():
	return _dependency

func get_commodity():
	return _commodity

func get_quantity():
	return _quantity
