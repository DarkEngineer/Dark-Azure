extends Node
class_name Market

var _sell_orders = []
var _buy_orders = []

enum ORDER_TYPES {SELL, BUY}

class Order:
	var _name
	var _amount
	var _price
	
	func _init(order_name, order_amount, order_price):
		_name = order_name
		_amount = order_amount
		_price = order_price

func _ready():
	pass

func create_order(o_name, o_amount, o_price) -> Order:
	var order = Order.new(o_name, o_amount, o_price)
	
	return order

func create_sell_order(o_name, o_amount, o_price):
	var order_obj = create_order(o_name, o_amount, o_price)
	_sell_orders.append(order_obj)

func create_buy_order(o_name, o_amount, o_price):
	var order_obj = create_order(o_name, o_amount, o_price)
	_buy_orders.append(order_obj)