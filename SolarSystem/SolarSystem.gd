extends Node2D

var Planet = preload("res://SolarSystem/Planet.tscn")

var _planets_created = 0

func _ready():
	randomize()
	for i in range(3):
		var planet_radius = create_planet_radius(_planets_created)
		create_planet(planet_radius)

func create_planet(radius):
	var planet = Planet.instance()
	var planet_name_format = "Planet_%d"
	var planet_name = planet_name_format % [_planets_created]
	add_child(planet)
	planet.set_name(planet_name)
	planet.set_position(radius)
	_planets_created += 1
	

func create_planet_radius(planet_count):
	var default_distance = 150.0
	var distance = default_distance * (planet_count + 1)
	var angle = randf() * 2.0 * PI
	
	var radius = Vector2()
	radius.x = cos(angle) * distance
	radius.y = sin(angle) * distance
	
	return radius
	