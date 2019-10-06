extends Object
class_name Star_System

var _system_id: int = -1
const STAR_SYSTEM_SIZE = 5000
const MIN_PLANET_DISTANCE = 700

var _planets = []

func _ready():
	randomize()

func generate_planet():
	var p_distance: float = randf() * STAR_SYSTEM_SIZE
	var r_ang: float = 0.0
	
	var new_pos = Vector2(cos(r_ang) * p_distance, sin(r_ang) * p_distance)
	
	