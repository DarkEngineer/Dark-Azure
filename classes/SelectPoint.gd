extends Area2D

var _objects = []

func _ready():
	pass

func _physics_process(delta):
	set_global_position(get_global_mouse_position())

func array_is_type(array, type) -> bool:
	for i in array:
		if not i.is_in_group(type):
			return false
	if array.empty():
		return false
	return true

func get_objects():
	var ships = global._select_array
	if array_is_type(ships, "Ships"):
		_objects = get_overlapping_bodies()
		$Timer.start()
		return true
	return false

func get_ships():
	var ships = global._select_array
	if array_is_type(ships, "Ships"):
		var mouse_pos_array = {
			"global": get_global_mouse_position(),
			"viewport": get_viewport().get_mouse_position()
		}
		if _objects.empty():
			global.emit_signal("trigger_command_panel", ships, "Ships", mouse_pos_array)
			return true
		else:
			global.emit_signal("trigget_target_command_panel", ships, "Ships", _objects, mouse_pos_array)
		
	return false

func _unhandled_input(event):
	if event.is_action_released("right_mouse") and $Timer.is_stopped():
		if not event.is_action("left_mouse"):
			get_objects()

func _on_Timer_timeout():
	$Timer.stop()
	get_ships()
