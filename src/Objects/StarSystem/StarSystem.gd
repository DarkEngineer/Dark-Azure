extends Node2D

var StaticObject = preload("res://src/Objects/StaticObject/StaticObject.tscn")

func _ready():
	_create_static_object()

func _create_static_object():
	var rand_radius = rand_range(0, 400)
	var rand_angle = rand_range(0, 2 * PI)
	
	var final_coord = Vector2(cos(rand_angle) * rand_radius, sin(rand_angle) * rand_radius)
	
	var static_object = StaticObject.instance()
	static_object.set_name("static_object_1")
	static_object.set_position(final_coord)
	
	$CelestialObjects.add_child(static_object)


