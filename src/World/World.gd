extends Node2D



func _ready():
	randomize()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		pass
"""
		if event.is_pressed():
			if selected.empty():
				dragging = true
				drag_start = get_global_mouse_position()
		elif dragging:
			dragging = false
			update()
			var drag_end = get_global_mouse_position()
			select_rect.extents =  (drag_end - drag_start) / 2.0
			var space = get_world_2d().direct_space_state
			var query = Physics2DShapeQueryParameters.new()
			query.set_shape(select_rect)
			query.transform = Transform2D(0, (drag_end - drag_start) / 2.0)
			selected = space.intersect_shape(query)
			print(selected)
	if event is InputEventMouseMotion and dragging:
		update()
"""
