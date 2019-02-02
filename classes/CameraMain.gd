extends Camera2D

var zoom_step = 1.1

func _ready():
	pass

func _unhandled_input(event):
	if event is InputEventMouse and current:
		if event.is_pressed() and not event.is_echo():
			var mouse_position = event.position
			if event.button_index == BUTTON_WHEEL_DOWN:
				if get_zoom().length() < Vector2(15.0, 15.0).length():
					set_zoom(get_zoom() + Vector2(zoom_step/ 5.0, zoom_step / 5.0))
			else : if event.button_index == BUTTON_WHEEL_UP:
				zoom_at_point(1/zoom_step,mouse_position)

func zoom_at_point(zoom_change, point):
	var c0 = position # camera position
	var v0 = get_viewport().size # vieport size
	var c1 # next camera position
	var z0 = zoom # current zoom value
	var z1 = z0 * zoom_change # next zoom value
	c1 = c0 + (-0.5*v0 + point)*(z0 - z1)
	if z1.length() < Vector2(1.0, 1.0).length():
		set_zoom(Vector2(1.0, 1.0))
	else:
		set_zoom(z1)
		set_position(c1)