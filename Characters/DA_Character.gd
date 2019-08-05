extends Object
class_name DA_Character

var _name: String = "default_character"
var _id: int = 0
var _statistics = []
var _traits = []

func _init(n):
	pass

func get_next_character_id():
	var id = global._next_character_id
	global._next_character_id += 1
	return id

func get_name():
	return _name

func get_id():
	return _id

func get_statistics():
	return _statistics.duplicate()

func get_traits():
	return _traits.duplicate()