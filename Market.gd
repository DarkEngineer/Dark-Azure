extends Node
class_name Market

var _sell_orders = []
var _buy_orders = []

var _traders = []

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
	
	func get_name():
		return _name
	
	func get_amount() -> int:
		return _amount
	
	func get_price():
		return _price
	
	func get_id():
		return _id
	
	func take_amount(units: int) -> bool:
		var t_units = abs(units)
		if t_units <= get_amount():
			_amount -= t_units
			return true
		return false
	
	func check_order():
		if get_amount() <= 0:
			free()
	

class Trader:
	var _orders = []
	var _average_price = 0.0

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

func order_check(buy_order, sell_order_array):
	var buy_amount = buy_order.get_amount()
	var buy_price = buy_order.get_price()
	for sell_order in sell_order_array:
		var sell_amount = sell_order.get_amount()
		var sell_price = sell_order.get_price()
		if buy_price >= sell_price:
			if buy_amount <= sell_amount:
				#resolve order
				resolve_order(buy_order, sell_order)

func resolve_order(buy_order: Order, sell_order: Order):
	sell_order.take_amount(buy_order.get_amount())
	buy_order.free()

func simulate_sell_orders(units):
	for i in range(units):
		create_sell_order("Coal", randi() % 300 + 1, randf() * 3.5 + 0.01, get_next_order_id())

func simulate_buy_orders(units):
	for i in range(units):
		create_buy_order("Coal", randi() % 300 + 1, randf() * 3.5 + 0.01, get_next_order_id())

func calculate_average_sell_price():
	var avg_price = 0.0
	for order in _sell_orders:
		avg_price += order.get_price()
	avg_price = avg_price / float(_sell_orders.size())
	return avg_price

func _on_Timer_timeout():
	simulate_sell_orders(randi() % 10)
	simulate_buy_orders(randi() % 20)
	$MarketInterface.update_sell_orders(_sell_orders)
	print(calculate_average_sell_price())
