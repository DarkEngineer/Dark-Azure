extends Node
class_name ESList

var _list: Array = []
var _avg: float

func add(n):
	_list.append(n)

func last_average(history: int):
	if _list.empty():
		return 0
	var skip = min(_list.size(), max(0, _list.size() - history))
	var end = min(_list.size() - 1, history)
	return average(get_range(skip,end))

func get_range(first: int, last: int):
	var t_arr = []
	for i in range(first, last, 1):
		t_arr.append(_list[i])
	return t_arr

func average(arr) -> float:
	var avg: float = 0.0
	for i in arr:
		avg += i
	avg /= arr.size()
	return avg

func get_size() -> int:
	return _list.size()

func get_list() -> Array:
	return _list
