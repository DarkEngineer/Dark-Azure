extends Node

var _main_camera_current_zoom: float = 0.0

enum SELECTION_MODE {
	NONE,
	SINGLE,
	MULTIPLE
}

var _galaxy_select_filter = {
	"single": ["Galaxy Ships", "Galaxy Stars"],
	"multiple": ["Galaxy Ships"]
}

func _ready():
	pass

func get_select_filter():
	return _galaxy_select_filter.duplicate()
