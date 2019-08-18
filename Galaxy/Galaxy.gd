extends Node2D

var Galaxy_Star = preload("res://Galaxy/GalaxyStar.tscn")

const DEFAULT_STARS_AMOUNT = 200
const DEFAULT_RANGE: float = 15000.0
const DEFAULT_DISTANCE_BETWEEN_STARS: float = 450.0

var _next_star_id: int = 1

func _ready():
	create_galaxy()

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
				star.set_position(Vector2(new_x, new_y))
				star.set_name("star_%d" % [set_star_id()])
				add_child(star)

func check_star_distance_from_others(new_position: Vector2, distance_between_stars: float):
	var g_stars = get_tree().get_nodes_in_group("Galaxy Stars")
	for star in g_stars:
		var distance = new_position - star.get_position()
		if distance.length() < DEFAULT_DISTANCE_BETWEEN_STARS:
			return false
	
	return true


