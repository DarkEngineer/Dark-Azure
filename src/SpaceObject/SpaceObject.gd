extends KinematicBody2D


var _acceleration = 50.0
var _speed = 0.0
var _velocity = Vector2.ZERO

var _rotation_speed = 20.0 # rotate deg/s

func _ready():
	pass


func select():
	$Select.show()

func unselect():
	$Select.hide()

func get_angle_to_direction(direction_vector: Vector2):
	var obj_vector = Vector2.RIGHT.rotated(get_rotation())
	var distinction = obj_vector.angle_to(direction_vector)
	print("Diff: ", rad2deg(distinction))
	return distinction
