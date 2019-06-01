extends StaticBody2D

onready var selection = $Select
onready var selection_anim = $Select/AnimationSelect

func _ready():
	pass


func _on_Planet_mouse_entered():
	var tooltip = global.tooltip
	tooltip.initialize(get_name())
	tooltip.show()


func _on_Planet_mouse_exited():
	var tooltip = global.tooltip
	tooltip.hide()


func play_selection_animation():
	selection_anim.play("Selection")

func stop_selection_animation():
	selection_anim.stop(true)

func _on_Planet_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_mouse"):
		selection.show()
		play_selection_animation()