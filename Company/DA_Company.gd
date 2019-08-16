extends Object
class_name DA_Company

var _funds: float = 0
var _workers_max: int = 0
var _workers: int = 0
var _products: float = 0
var _product_price: float = 0
var _population_workers: DA_Population

var _planet_ref

func _init(planet_ref, f, w_max, p, p_price, pop):
	_planet_ref = planet_ref
	add_funds(f)
	_workers_max = w_max
	produce(p)
	_product_price = p_price
	_population_workers = pop

func add_funds(amount: float):
	_funds += amount

func take_funds(amount: float):
	_funds -= amount
	return amount

func add_workers(quantity: int):
	_workers = min(_workers_max, _workers + quantity)

func fire_workers(quantity: int):
	_workers = max(0, _workers - quantity)

func work_pay(amount: float):
	var payment = amount * _workers

func produce(amount):
	_products += amount

func sell_product(amount):
	_products -= amount
	return amount

func get_products():
	return _products

func get_product_price():
	return _product_price