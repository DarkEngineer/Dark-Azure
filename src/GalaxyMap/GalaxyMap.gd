extends Node2D

var Star = preload("res://src/GalaxyMap/Objects/Star/Star.tscn")
var StarSystem = preload("res://src/GalaxyMap/Objects/StarSystem/StarSystem.tscn")

const STAR_DISTANCE = 500.0

onready var _stars = $Stars
onready var _star_systems = $StarSystems

var _stars_quantity: int = 50
var _galaxy_radius: float = 30000.0

var _active_star_system = null


func _ready():
	generate_galaxy()
	generate_star_systems()
	
	connect_signals()

func generate_galaxy():
	var star_id: int = 1
	var star_list = get_tree().get_nodes_in_group("Stars")
	for i in range(_stars_quantity):
		var star = Star.instance()
		star.set_name("Star_%d" % [star_id])
		var r_coord = generate_random_star_coords()
		
		star.set_position(r_coord)
		star.set_id(star_id)
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
	for star in get_star_list():
		var star_system = StarSystem.instance()
		star_system.set_name("StarSystem_%d" % [star.get_id()])
		star_system.set_global_position(star.get_global_position())
		_star_systems.add_child(star_system)
		star.set_star_system(star_system)

func get_star_list():
	return get_tree().get_nodes_in_group("Stars")

func star_distance(target_star: Area2D, compared_star: Area2D):
	var target_position = target_star.get_position()
	var compared_position = compared_star.get_position()
	
	var distance = target_position.distance_to(compared_position)
	return distance

func connect_signals():
# warning-ignore:return_value_discarded
	global.connect("changed_to_star_system", self, "_on_star_system_view")

func set_active_star_system(system):
	_active_star_system = system

func clear_active_star_system():
	_active_star_system = null

func get_active_star_system():
	return _active_star_system


func _on_star_system_view(system_data):
	_stars.hide()
	system_data.show()
	set_active_star_system(system_data)

