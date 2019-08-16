extends Object
class_name DA_Syndicate

var _funds: float = 0
var _gangsters: int = 0

var _planet_ref

func _init(planet_ref, f = 0, g = 1):
	_planet_ref = planet_ref
	_funds = f
	recruit(g)

func recruit(amount):
	_gangsters += amount

func fire_gangsters(amount):
	_gangsters -= amount

func rob(amount):
	_funds += amount

func pay_roll(amount):
	var payment: float = amount / float(_gangsters)
	return payment