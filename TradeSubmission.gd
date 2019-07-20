extends Node
class_name TradeSubmission

var _list: Dictionary # structure of list - Dictionary<string, Trade>

func add(n: String, t):
	_list[n] = t

func get_list():
	return _list

