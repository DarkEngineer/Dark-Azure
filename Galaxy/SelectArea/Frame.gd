extends Node2D

var _frame_coords: Dictionary = {
	"top_left": null,
	"top_right": null,
	"bottom_left": null,
	"bottom_right": null
}

var _continue_frame_drawing = false

const _line_color = Color.antiquewhite
const _line_width = 4.0

func _ready():
	pass

func _process(delta):
	if owner._select_started:
		if not _continue_frame_drawing:
			_continue_frame_drawing = true

func _draw():
	if _continue_frame_drawing:
		draw_line(_frame_coords.top_left, _frame_coords.top_right, _line_color, _line_width)
		

func get_screen_coordinates(g_pos):
	#var screen_coord = get_viewport_transform() * (owner.get_global_transform() * local_pos)
	var screen_coord = 0
	
	return screen_coord