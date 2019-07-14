extends Node
class_name Trader

var ORDER_TYPES = Market.ORDER_TYPES

var _id: int = -1
var _average_price_array: Dictionary = {}
var _price_range_array: Dictionary = {}
var _available_resources = []
var _available_funds: int = 0


func _init(id: int):
	_id = id

func get_id():
	return _id

func make_buy_order(market, o_name: String, o_amount: int, o_price: float):
	market.create_buy_order(o_name, o_amount, o_price)

func make_sell_order(market, o_name: String, o_amount: int, o_price: float):
	market.create_sell_order(o_name, o_amount, o_price)

func add_resources(r_name: String, r_amount: int) -> bool:
	for r_obj in _available_resources:
		if r_obj.name == r_name:
			r_obj.amount += r_amount
			return true
	_available_resources.append({
		"name": r_name,
		"amount": r_amount
	})
	return true