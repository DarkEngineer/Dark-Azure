extends Node2D

var _travel_array = []

func _ready():
	pass

func _draw():
	pass

func _on_galaxy_ship_started_travel(galaxy_travel):
	_travel_array.append(galaxy_travel)

func _on_galaxy_ship_aborted_travel(galaxy_travel):
	_travel_array.erase(galaxy_travel)

func refresh_travel_paths():
	pass