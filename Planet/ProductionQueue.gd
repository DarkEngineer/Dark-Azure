extends Object
class_name ProductionQueue

var _product
var _timer: Timer
var _quantity

func _init():
	_timer = Timer.new()
	_timer.set_name("Production_Timer")
	_timer.connect("timeout", self, "on_production_timeout")

func add_product_details(p, t, q):
	_product = p
	_timer.set_wait_time(t)
	_quantity = q

func on_production_timeout():
	pass
