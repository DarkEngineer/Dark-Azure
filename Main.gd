extends Node2D

func _ready():
	connect_signals()

func connect_signals():
	global.connect("galaxy_view_selected", self, "_on_galaxy_view")
	global.connect("star_system_selected", self, "_on_star_system_view")

func _on_galaxy_view(star_node):
	$MainCamera.make_current()

func _on_star_system_view(star_node):
	$MainCamera.set_position(Vector2(0, 0))