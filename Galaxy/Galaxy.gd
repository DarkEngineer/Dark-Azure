extends Node2D

const STAR_COUNT = 1000
const GALAXY_RADIUS = 50000
const DISTANCE_BETWEEN_STARS = 100

var Star_Node = preload("res://Galaxy/StarNode.tscn")

var _next_star_id = 1

func _ready():
	randomize()
	generate_eliptic_galaxy()
	
	connect_signals()

func connect_signals():
# warning-ignore:return_value_discarded
	global.connect("star_system_selected", self, "_on_star_system_view")
# warning-ignore:return_value_discarded
	global.connect("galaxy_view_selected", self, "_on_galaxy_view")

func _on_star_system_view(star_node):
	$GalaxyStars.hide()
	$StarSystem.show()

func _on_galaxy_view(star_node):
	$GalaxyStars.show()
	$StarSystem.hide()

#galaxy creation function
####################################################
func generate_eliptic_galaxy():
# warning-ignore:unused_variable
	for i in range(STAR_COUNT):
		
		var new_angle = rand_range(0, 2 * PI)
		var new_distance = randf() * GALAXY_RADIUS
		
		var new_pos = Vector2(cos(new_angle) * new_distance, sin(new_angle) * new_distance)
		
		$GalaxyStars.add_child(create_star_node(get_next_star_id(), new_pos))

func create_star_node(star_id: int, new_position: Vector2) -> Node2D:
	var t_star = Star_Node.instance()
	t_star.set_name("StarNode_%d" % [star_id])
	t_star.set_position(new_position)
	return t_star

func get_next_star_id():
	var star_id = _next_star_id
	_next_star_id += 1
	return star_id

func assign_system_to_node():
	pass
#################################
