extends Node2D

var StarObject = preload("res://src/GalaxyMap/Objects/StarObject/StarObject.tscn")
var Planet = preload("res://src/GalaxyMap/Objects/StarSystem/Objects/Planet.tscn")

const DEFAULT_DISTANCE = 2000.0
const MAX_PATH_QUANTITY = 9

var _planet_paths = []

func _ready():
	generate_sun()
	generate_planet_paths()
	generate_planets()

func generate_sun():
	var star = StarObject.instance()
	star.set_position(Vector2(0, 0))
	star.set_name("System Star 1")
	add_child(star)

func generate_planets():
	for path in _planet_paths:
		var planet = Planet.instance()
		planet.set_name("Planet_%d" % path.multiplier)
		
	

func generate_planet_paths():
	var planet_quantity = randi() % 5 + 1
	var multiply_array = []
	
	while multiply_array.size() < planet_quantity:
		var rand_multiply = randi() % MAX_PATH_QUANTITY
		if not multiply_array.has(rand_multiply):
			multiply_array.append(rand_multiply)
	
	for i in range(planet_quantity):
		_planet_paths.append({"multiplier": multiply_array[i]})

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)


func _draw():
	for path in _planet_paths:
		draw_circle_arc(Vector2(0, 0), DEFAULT_DISTANCE * path.multiplier, 0, rad2deg(2 * PI), Color.gray)
