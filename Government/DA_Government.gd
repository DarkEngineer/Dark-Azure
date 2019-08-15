extends Object
class_name DA_Government

var _funds: float = 0
var _workers: int = 0
var _tax_rate: float = 0

func _init(funds, tax_rate):
	pass

func add_funds(amount):
	_funds += amount

func take_funds(amount):
	_funds -= amount

func add_workers(quantity):
	_workers += quantity

func fire_workers(quantity):
	_workers -= quantity

func set_tax_rate(n):
	_tax_rate = min(n, 1)

