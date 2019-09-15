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

#Game to UI signals###################
signal target_mouse_selected(obj_array)
######################################
#UI to Game signals###################
signal objects_moved_to_target(target)
######################################

#Change scene signals#################
signal galaxy_star_picked(galaxy_star)
signal galaxy_map_picked()
######################################

func _ready():
	pass

func get_select_filter():
	return _galaxy_select_filter.duplicate()