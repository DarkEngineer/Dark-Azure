extends Node
class_name Market

var _sell_orders = []
var _buy_orders = []

var _traders = []

var _next_order_id = 0
var _next_trader_id = 0

enum ORDER_TYPES {SELL, BUY}

signal trader_orders_requested(trader_id, type)


func _ready():
	connect("trader_orders_requested", self, "on_get_trader_orders")

func get_next_order_id():
	var id = _next_order_id
	_next_order_id += 1
	return id

func create_order(o_name: String, o_amount: int, o_price: float, o_id: int) -> Order:
	var order = Order.new(o_name, o_amount, o_price, o_id)
	
	return order

func create_sell_order(o_name: String, o_amount: int, o_price: float) -> Order:
	var order_obj = create_order(o_name, o_amount, o_price, get_next_order_id())
	_sell_orders.append(order_obj)
	return order_obj

func create_buy_order(o_name: String, o_amount: int, o_price: float) -> Order:
	var order_obj = create_order(o_name, o_amount, o_price, get_next_order_id())
	_buy_orders.append(order_obj)
	order_check(order_obj, _sell_orders)
	return order_obj

func order_check(buy_order, sell_order_array):
	var buy_amount = buy_order.get_amount()
	var buy_price = buy_order.get_price()
	for sell_order in sell_order_array:
		var sell_amount = sell_order.get_amount()
		var sell_price = sell_order.get_price()
		if buy_price >= sell_price:
			if buy_amount <= sell_amount:
				#resolve order
				resolve_buy_order(buy_order, sell_order)
				resolve_sell_order(sell_order)

func resolve_buy_order(buy_order: Order, sell_order: Order):
	sell_order.take_amount(buy_order.get_amount())
	_buy_orders.erase(buy_order)
	print("Bought %d %s by price of %f" % [buy_order.get_amount(), buy_order.get_name(), sell_order.get_price()])

func resolve_sell_order(sell_order: Order):
	if sell_order.get_amount() == 0:
		_sell_orders.erase(sell_order)

func simulate_sell_orders(units):
	for i in range(units):
		create_sell_order("Coal", randi() % 300 + 1, randf() * 3.5 + 0.01)

func simulate_buy_orders(units):
	for i in range(units):
		create_buy_order("Coal", randi() % 250 + 30, randf() * 3.5 + 0.01)

func calculate_average_sell_price():
	var avg_price = 0.0
	for order in _sell_orders:
		avg_price += order.get_price()
	avg_price = avg_price / float(_sell_orders.size())
	return avg_price

func on_get_trader_orders(id, type):
	pass

func _on_Timer_timeout():
	simulate_sell_orders(randi() % 10)
	simulate_buy_orders(randi() % 20)
	$MarketInterface.update_sell_orders(_sell_orders)
	$MarketInterface.update_buy_orders(_buy_orders)
