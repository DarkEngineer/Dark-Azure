extends Node
class_name Trader

var ORDER_TYPES = Market.ORDER_TYPES

var _id: int = -1
var _average_price_array: Dictionary = {}
var _price_range_array: Dictionary = {}
var _available_resources = []
var _resources_usage = []
var _available_funds: int = 0
var _orders = [] #array of orders id


func _init(id: int):
	_id = id

func get_id():
	return _id
