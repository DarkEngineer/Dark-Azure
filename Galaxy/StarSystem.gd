extends Node2D

func _ready():
	connect_signals()

func connect_signals():
# warning-ignore:return_value_discarded
	global.connect("star_system_selected", self, "_on_star_system_view")

func _on_star_system_view(star_node):
	pass