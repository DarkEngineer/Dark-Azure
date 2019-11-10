extends Node2D

var Star = preload("res://src/GalaxyMap/Objects/Star.tscn")
var StarSystem = preload("res://src/GalaxyMap/Objects/StarSystem/StarSystem.tscn")

const STAR_DISTANCE = 500.0


var _stars_quantity: int = 50
var _galaxy_radius: float = 30000.0

onready var _stars = $Stars

func _ready():
	generate_galaxy()

func generate_galaxy():
	var star_id: int = 1
	var star_list = get_tree().get_nodes_in_group("Stars")
	for i in range(_stars_quantity):
		var star = Star.instance()
		star.set_name("Star_%d" % [star_id])
		var r_coord = generate_random_star_coords()
		
		star.set_position(r_coord)
		_stars.add_child(star)
		star_id += 1

func generate_random_star_coords() -> Vector2:
	var r_range = randf() * _galaxy_radius
	var r_angle = rand_range(0, 2 * PI)
	
	var r_coord = Vector2(
		cos(r_angle) * r_range,
		sin(r_angle) * r_range
		)
	
	return r_coord

func generate_star_systems():
	var star_system = StarSystem.instance()
