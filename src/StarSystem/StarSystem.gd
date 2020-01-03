extends Node2D

var PlanetBody = preload("res://src/PlanetBody/PlanetBody.tscn")

var _next_trail_id = 1
var _next_system_planet_id = 1

func _ready():
	for i in range(1000, 10000, 1000):
		add_planet(create_planet_trail(i))

func create_planet_trail(radius = 50.0):
	var line = Line2D.new()
	line.set_name("path_%d" % [_next_trail_id])
	_next_trail_id += 1
	
	var disk_points_array: PoolVector2Array = PoolVector2Array()
	
	var disk_middle: Vector2 = Vector2.ZERO
	
	var start_range: float = 0.0
	var end_range: float = 360.0
	var step: float = 15.0
	
	for i in range(start_range, end_range, step):
		var new_vector = Vector2(cos(deg2rad(i)) * radius, sin(deg2rad(i)) * radius) + disk_middle
		disk_points_array.append(new_vector)
	disk_points_array.append(disk_points_array[0])
	
	for v in disk_points_array:
		line.add_point(v)
	
	$CelestialTrails.add_child(line)
	
	return disk_points_array

func add_planet(celestial_trail):
	var planet = PlanetBody.instance()
	planet.set_name("planet_%d" % [_next_system_planet_id])
	planet._name = "Object %d" % [_next_system_planet_id]
	
	procedural_planet_placement(planet, celestial_trail)
	
	$CelestialBodies.add_child(planet)
	_next_system_planet_id += 1

func procedural_planet_placement(planet, planet_trail: PoolVector2Array): 
	planet.set_position_on_trail(planet_trail)
	
