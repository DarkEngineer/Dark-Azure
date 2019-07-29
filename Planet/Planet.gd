extends Area2D
class_name Planet

var _name: String = ""
var _buildings = []


class Commodity:
	var _name: String setget , get_name
	
	func _init(n):
		_name = n
	
	func get_name():
		return _name

class Building:
	var _name: String
	var _production = []
	
	func _init(n):
		_name = n
	
	func add_production(c: Commodity, n: int):
		var product = {
			"commodity": c,
			"quantity": n
		}
		_production.append(product)
	

func _ready():
	pass
