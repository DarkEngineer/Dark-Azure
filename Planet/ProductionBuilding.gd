extends Building
class_name ProductionBuilding

var _blueprints = []
var _production_queue

func _init(n).(n):
	pass

func add_blueprint(b: Blueprint):
	_blueprints.append(b)

func get_blueprints():
	return _blueprints.duplicate()

func update_production():
	var c = get_blueprints().front().get_commodity()
	var q = get_blueprints().front().get_quantity()
	add_inventory(c, q)


func update():
	update_production()