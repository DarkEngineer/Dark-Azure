extends Node2D

var _obj = []

func _ready():
	var stars = get_tree().get_nodes_in_group("Galaxy Stars")
	for i in range(2):
		_obj.append(stars[i])



func _draw():
	var coords = []
	for i in _obj:
		coords.append(i.get_position())
	draw_line(coords[0], coords[1], Color.red, 10, true)
	update()