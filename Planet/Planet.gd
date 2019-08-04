extends Area2D
class_name Planet

var _name: String = ""
var _buildings = []


func _ready():
	add_building("Mine")


func add_building(n: String):
	var b = ProductionBuilding.new(n)
	b.add_blueprint(initialize_blueprint())
	_buildings.append(b)
	

func initialize_blueprint():
	var bd = BlueprintDependency.new()
	bd.add("Food", 2)
	var bp = Blueprint.new("Coal", 1, bd)
	return bp

func planet_update():
	for b in _buildings:
		b.update()