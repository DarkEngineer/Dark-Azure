extends Area2D
class_name Planet

var _name: String = ""
var _buildings = []


class Commodity:
	var _name: String
	var _

class Building:
	var _name: String
	var _production = []
	
	func _init(n, p):
		_name = n
		_production = p
	

func _ready():
	pass
