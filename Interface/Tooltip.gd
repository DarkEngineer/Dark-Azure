extends PanelContainer



func _ready():
	connect_game_signals()

func connect_game_signals():
	global.connect("mouse_asteroid_focused", self, "_show_asteroid_info")
	global.connect("mouse_asteroid_focus_lost", self, "_hide_tooltip")

func _show_asteroid_info(asteroid: Asteroid):
	show()

func _hide_tooltip():
	hide()

func _on_Tooltip_draw():
	set_position(get_viewport().get_mouse_position())
