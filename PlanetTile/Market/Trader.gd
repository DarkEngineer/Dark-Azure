extends Node
class_name Trader

var ORDER_TYPES = Market.ORDER_TYPES

var _id: int = -1
var _average_price_array: Dictionary = {}
var _price_range_array: Dictionary = {}

func get_id():
	return _id

func make_buy_order(market: Market, o_name: String, o_amount: int, o_price: float):
	market.create_buy_order(o_name, o_amount, o_price)

func make_sell_order(market: Market, o_name: String, o_amount: int, o_price: float):
	market.create_sell_order(o_name, o_amount, o_price)

func request_for_buy_orders(market: Market):
	market.emit_signal("trader_orders_requested", get_id(), ORDER_TYPES.SELL)