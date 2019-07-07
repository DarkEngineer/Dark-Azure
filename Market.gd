extends Node
class_name Market

var _sell_orders = []
var _buy_orders = []

var _next_order_id = 0

enum ORDER_TYPES {SELL, BUY}

class Order:
	var _name
	var _amount
	var _price
	var _id
	
	func _init(order_name, order_amount, order_price, order_id):
		_name = order_name
		_amount = order_amount
		_price = order_price
		_id = order_id

func _ready():
	pass

func get_next_order_id():
	var id = _next_order_id
	_next_order_id += 1
	return id

func create_order(o_name, o_amount, o_price, o_id) -> Order:
	var order = Order.new(o_name, o_amount, o_price, o_id)
	
	return order

func create_sell_order(o_name, o_amount, o_price, o_id):
	var order_obj = create_order(o_name, o_amount, o_price, o_id)
	_sell_orders.append(order_obj)

func create_buy_order(o_name, o_amount, o_price, o_id):
	var order_obj = create_order(o_name, o_amount, o_price, o_id)
	_buy_orders.append(order_obj)

func simulate_sell_orders(count):
	for i in range(count):
		var c_name = "Coal"
		var c_amount = randi() % 4000 + 100
		var c_price = randf() * 4.5 + 1.0
		