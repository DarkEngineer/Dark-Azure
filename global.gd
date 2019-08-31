extends Node

var _main_camera_current_zoom: float = 0.0

enum SELECTION_MODE {
	NONE,
	SINGLE,
	MULTIPLE
}

var _galaxy_select_filter = {
	"basic": ["Galaxy Ships"],
	"single": ["Galaxy Ships", "Galaxy Stars"]
}

func _ready():
	pass
