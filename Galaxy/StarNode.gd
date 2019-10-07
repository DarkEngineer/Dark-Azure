extends Node2D

func _ready():
	set_physics_process(false)
	set_process(false)

# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_StarNode_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_mouse"):
		global.emit_signal("star_system_selected", self)
