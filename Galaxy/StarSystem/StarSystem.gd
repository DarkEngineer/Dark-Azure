extends Node2D

var Asteroid = preload("res://Galaxy/Asteroid/Asteroid.tscn")

func _ready():
	randomize()
	create_asteroid_belt(1500, 150)
	hide()

func create_asteroid_belt(distance_from_center: float, belt_width: float):
	for i in range(20):
		var r_angle = rand_range(0, 2 * PI)
		var r_distance = rand_range(distance_from_center - belt_width / 2.0, 
				distance_from_center + belt_width / 2.0)
		
		var asteroid = Asteroid.instance()
		
		var new_x = cos(r_angle) * r_distance
		var new_y = sin(r_angle) * r_distance
		
		asteroid.set_id(i)
		asteroid.set_name("asteroid_%d" % [i])
		asteroid.set_position(Vector2(new_x, new_y))
		add_child(asteroid)