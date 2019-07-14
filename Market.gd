extends Node
class_name Market

var _sell_orders = []
var _buy_orders = []

var _traders = []

var _next_order_id = 0
var _next_trader_id = 0

enum ORDER_TYPES {SELL, BUY}

signal trader_orders_requested(trader_id, type)

onready var _market_log = $MarketLog

func _ready():
	connect("trader_orders_requested", self, "on_get_trader_orders")

func get_next_order_id():
	var id = _next_order_id
	_next_order_id += 1
	return id

func get_next_trader_id():
	var t_id = _next_trader_id
	_next_trader_id += 1
	return t_id

func get_traders() -> Array:
	return _traders

func create_order(o_name: String, o_amount: int, o_price: float, o_id: int, o_trader_id: int = -1) -> Order:
	var order = Order.new(o_name, o_amount, o_price, o_id, o_trader_id)
	_market_log.order_created(order)
	return order

func create_sell_order(o_name: String, o_amount: int, o_price: float) -> Order:
	var order_obj = create_order(o_name, o_amount, o_price, get_next_order_id())
	_sell_orders.append(order_obj)
	return order_obj

func create_buy_order(o_name: String, o_amount: int, o_price: float) -> Order:
	var order_obj = create_order(o_name, o_amount, o_price, get_next_order_id())
	_buy_orders.append(order_obj)
	return order_obj