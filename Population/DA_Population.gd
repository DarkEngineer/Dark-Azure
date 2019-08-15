extends Object
class_name DA_Population

var _quantity: float = 0 # how big population is
var _workforce: int = 0 # how many are working
var _funds: float = 0 # how much money there is for population
var _inventory: float = 0
var _consumption: float = 0

func _init(q, f, c):
	add_quantity(q)
	add_funds(f)
	set_consumption(c)

func add_workforce(amount: int):
	_workforce += amount

func add_funds(amount: float):
	_funds += amount

func add_quantity(amount: float):
	_quantity += amount

func set_consumption(amount: float):
	_consumption = amount