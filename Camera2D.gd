extends Camera2D

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("scroll_down_mouse"):
		zoom += Vector2(0.2, 0.2)
	if event.is_action_pressed("scroll_up_mouse"):
		zoom -= Vector2(0.2, 0.2)