extends SpaceObject
class_name Asteroid

var _minerals = [1250]

func _ready():
	pass

func get_composition():
	return _minerals.duplicate()


func _on_Asteroid_mouse_entered():
	global.emit_signal("mouse_asteroid_focused", self)


func _on_Asteroid_mouse_exited():
	global.emit_signal("mouse_asteroid_focus_lost")
