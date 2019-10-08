extends Node


# Signals from Game to UI
########################
signal mouse_asteroid_focused(asteroid)
signal mouse_asteroid_focus_lost()
########################
# Signals from UI to Game

########################

func _ready():
	randomize()
