extends Node
class_name Trade

var _commodity: String
var _price: float
var _quantity: float
var _agent

func _init(c: String, p: float, q: float, a):
	_commodity = c
	_price = p
	_quantity = q
	_agent = a

func reduce(q: float):
	_quantity -= q
	return _quantity

func print_info():
	print("%s: %s trade: %f, %f" % [_agent.get_identity_name(), _commodity, _price, _quantity])

