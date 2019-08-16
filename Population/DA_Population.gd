extends Object
class_name DA_Population

var _quantity: float = 0 # how big population is
var _growth_rate: float = 0.01

signal month_changed(data)

#References
var _planet_ref

func _init(q):
	_quantity = q
	global.connect("month_passed", self, "month_end")

func grow_population():
	var new_pop = _quantity * _growth_rate
	_quantity += new_pop

func create_data_for_ui() -> Dictionary:
	var data = {
		"pop_quantity": _quantity,
		"growth_rate": _growth_rate,
		"consumption_value": 0
	}
	return data

func month_end():
	grow_population()
	var pop_data = create_data_for_ui()
	emit_signal("month_changed", pop_data)