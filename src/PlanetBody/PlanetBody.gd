extends "res://src/CelestialBody/CelestialBody.gd"

var _planet_trail_array: PoolVector2Array setget set_trail, get_trail

var _next_trail_point_index: int = 0
var _current_trail_point_index: int = 0


func _ready():
	generate_minerals()

func set_position_on_trail(trail):
	var rand_trail_index = randi() % trail.size()
	set_trail_details(trail.size(), rand_trail_index)
	set_position(trail[rand_trail_index])
	set_trail(trail)

func set_trail(trail):
	_planet_trail_array = trail

func get_trail() -> PoolVector2Array:
	return _planet_trail_array

func set_trail_details(trail_size, index):
	_current_trail_point_index = index
	if index < trail_size - 1:
		_next_trail_point_index = index + 1
	else:
		_next_trail_point_index = 0

func move_planet_to_next_point():
	set_position(_planet_trail_array[_next_trail_point_index])
	set_trail_details(get_trail().size(), _next_trail_point_index)


func _on_TrailTimer_timeout():
	move_planet_to_next_point()
