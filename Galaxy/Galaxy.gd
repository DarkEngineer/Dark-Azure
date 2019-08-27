extends Node2D

var Galaxy_Star = preload("res://Galaxy/GalaxyStar/GalaxyStar.tscn")
var Galaxy_Geometrics = preload("res://Galaxy/GalaxyGeometrics/GalaxyGeometrics.tscn")
var Galaxy_UI = preload("res://GalaxyUI/GalaxyUI.tscn")
var Galaxy_Ship = preload("res://GalaxyUI/GalaxyShip.tscn")

const DEFAULT_STARS_AMOUNT = 200
const DEFAULT_RANGE: float = 15000.0
const DEFAULT_DISTANCE_BETWEEN_STARS: float = 450.0

var _next_star_id: int = 1
var _current_active_galaxy_ships = 0

var _selected = []

# References
var _galaxy_geometrics_ref = null

func _ready():
	create_galaxy()
	create_galaxy_geometrics()
	create_galaxy_ui()
	create_galaxy_ship()

func set_star_id():
	var star_id = _next_star_id
	_next_star_id += 1
	return star_id

func create_galaxy():
	var stars_created = 0
	for i in range(DEFAULT_STARS_AMOUNT):
		var star = Galaxy_Star.instance()
		var if_far_enough = false
		while not if_far_enough:
			var r_angle = rand_range(0, 2 * PI)
			var r_distance = rand_range(0, DEFAULT_RANGE)
			
			var new_x = cos(r_angle) * r_distance
			var new_y = sin(r_angle) * r_distance
			if_far_enough = check_star_distance_from_others(Vector2(new_x, new_y), 
					DEFAULT_DISTANCE_BETWEEN_STARS)
			if if_far_enough:
				var new_id = set_star_id()
				star.set_position(Vector2(new_x, new_y))
				star.set_name("star_%d" % [new_id])
				star.set_id(new_id)
				add_child(star)

func check_star_distance_from_others(new_position: Vector2, distance_between_stars: float):
	var g_stars = get_tree().get_nodes_in_group("Galaxy Stars")
	for star in g_stars:
		var distance = new_position - star.get_position()
		if distance.length() < DEFAULT_DISTANCE_BETWEEN_STARS:
			return false
	
	return true

func create_galaxy_geometrics():
	var g_geometry = Galaxy_Geometrics.instance()
	g_geometry.set_name("GalaxyGeometrics")
	_galaxy_geometrics_ref = g_geometry
	add_child(g_geometry)

func create_galaxy_ui():
	var g_ui = Galaxy_UI.instance()
	g_ui.set_name("GalaxyUI")
	add_child(g_ui)
	g_ui.create_star_systems_text()

func increase_galaxy_ship_count():
	_current_active_galaxy_ships += 1

func decrease_galaxy_ship_count():
	_current_active_galaxy_ships -= 1

func get_galaxy_ship_count():
	return _current_active_galaxy_ships

func create_galaxy_ship():
	var g_ship = Galaxy_Ship.instance()
	increase_galaxy_ship_count()
	g_ship.set_name("Galaxy_Ship_%d" % [get_galaxy_ship_count()])
	add_child(g_ship)

func _on_galaxy_ship_selected(ship):
	_selected.append(ship)