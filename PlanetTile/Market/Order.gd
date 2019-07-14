extends Node
class_name Order

var _name
var _amount
var _price
var _id
var _trader_id
var _time

func _init(order_name, order_amount, order_price, order_id, trader_id):
	_name = order_name
	_amount = order_amount
	_price = order_price
	_id = order_id
	_trader_id = trader_id

func get_name():
	return _name

func get_amount() -> int:
	return _amount

func get_price():
	return _price

func get_id():
	return _id

func get_trader_id():
	return _trader_id

func get_time_decay():
	return _time

func take_amount(units: int) -> bool:
	var t_units = abs(units)
	if t_units <= get_amount():
		_amount -= t_units
		return true
	return false
