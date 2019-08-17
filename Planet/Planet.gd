extends Area2D

class DA_Population:
	var _quantity: float
	var _workers: int
	var _funds: float
	
	func add_funds(amount):
		_funds += amount

class DA_Company:
	var _workers_max: int
	var _workers: int
	var _avg_salary: float
	
	func add_workers(q):
		_workers += q
	
	func fire_workers(q):
		_workers -= q
	
	func pay_salary_for(pop):
		var total_salary = _workers * _avg_salary
		

func _ready():
	pass
