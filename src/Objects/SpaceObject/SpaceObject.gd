extends Area2D

var _contain_resources: bool = false

var _raw_minerals = []

func add_raw_mineral(new_mineral):
	_raw_minerals.append(new_mineral)

func decrease_raw_mineral(mineral):
	pass


func _on_SpaceObject_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_mouse"):
		print("Selected")
