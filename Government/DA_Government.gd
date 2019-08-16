extends Object
class_name DA_Government

var _funds: float = 0
var _workers: int = 0
var _tax_rate: float = 0

var _planet_ref

func _init(planet_ref, funds, tax_rate):
	_planet_ref = planet_ref
	_funds = funds
	_tax_rate = tax_rate

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

