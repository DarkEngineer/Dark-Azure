extends Node2D

var _travel_array = []

var _line_color: Color = Color.gray
var _line_width: float = 2.0

func _ready():
	pass

func _draw():
	for path in _travel_array:
		draw_travel_path(path)

func _on_galaxy_ship_started_travel(galaxy_travel):
	_travel_array.append(galaxy_travel)

func _on_galaxy_ship_aborted_travel(galaxy_travel):
	_travel_array.erase(galaxy_travel)

func draw_travel_path(travel_path: GalaxyTravel):
	var obj_pos = travel_path.get_object().get_position()
	var dest_pos = travel_path.get_destination()
	draw_line(dest_pos, obj_pos, _line_color, _line_width, true)

func refresh_travel_paths():
	update()

func _on_RefreshTimer_timeout():
	refresh_travel_paths()
