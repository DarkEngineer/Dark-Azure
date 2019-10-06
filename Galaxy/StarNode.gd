extends Node2D

func _ready():
	pass

func _on_StarNode_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_mouse"):
		global.emit_signal("star_system_selected", self)
		print("G")