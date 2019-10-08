extends Node2D

var Star = preload("res://Star_System/Star.tscn")
var Asteroid = preload("res://Space_Object/Asteroid.tscn")

var _next_asteroid_id: int = 1
var _next_planet_id: int = 1

func _ready():
	create_star()
	for i in range(5):
		create_asteroid()

func create_star():
	var star_obj = Star.instance()
	star_obj.set_name("Star")
	star_obj.set_position(Vector2(0, 0))
	add_child(star_obj)

func create_asteroid():
	var asteroid_obj = Asteroid.instance()
	var asteroid_id = get_next_asteroid_id()
	
	var rand_distance = rand_range(300, 3500)
	var rand_angle = rand_range(0, 2 * PI)
	var new_pos = Vector2(cos(rand_angle) * rand_distance, sin(rand_angle) * rand_distance)
	
	asteroid_obj.set_name("Asteroid_%d" % [asteroid_id])
	asteroid_obj.set_position(new_pos)
	
	add_child(asteroid_obj)
	

func get_next_asteroid_id():
	var next_id = _next_asteroid_id
	_next_asteroid_id += 1
	return next_id

func get_next_planet_id():
	var next_id = _next_planet_id
	_next_planet_id += 1
	return next_id
