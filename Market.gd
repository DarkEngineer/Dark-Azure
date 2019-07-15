extends Node
class_name Market

var _orders = []
var _traders = []

var _next_order_id = 0
var _next_trader_id = 0

enum ORDER_TYPES {SELL, BUY}

onready var _market_log = $MarketLog
onready var _trader_list = $TradersPanel

func _ready():
	pass

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

