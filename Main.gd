extends Node2D

func _ready():
	connect_signals()

func connect_signals():
# warning-ignore:return_value_discarded
	global.connect("galaxy_view_selected", self, "_on_galaxy_view")
# warning-ignore:return_value_discarded
	global.connect("star_system_selected", self, "_on_star_system_view")

func _on_galaxy_view(star_node):
	$MainCamera.make_current()
	$UILayer/ToGalaxyView.hide()

func _on_star_system_view(star_node):
	$MainCamera.set_position(Vector2(0, 0))
	$UILayer/ToGalaxyView.show()

func _on_ToGalaxyView_pressed():
	global.emit_signal("galaxy_view_selected", null)
