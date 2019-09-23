extends Node2D

const STAR_COUNT = 1000
const GALAXY_RADIUS = 50000
const DISTANCE_BETWEEN_STARS = 100

var Star_Node = preload("res://Galaxy/StarNode.tscn")

var _next_star_id = 1

func _ready():
	randomize()

#galaxy creation function
func create_eliptic_galaxy():
	var new_angle = rand_range(0, 2 * PI)
	var new_distance = randf() * GALAXY_RADIUS
	
	var new_pos = Vector2(cos(new_angle) * new_distance, sin(new_angle) * new_distance)
	create_star_node(_next_star_id, new_pos)

func create_star_node(star_id: int, new_position):
	var t_star = Star_Node.instance()
	t_star.set_name("StarNode_%d" % [star_id]) 
#################################