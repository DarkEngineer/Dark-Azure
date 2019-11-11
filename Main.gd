extends Node2D


func _ready():
# warning-ignore:return_value_discarded
	global.connect("changed_to_star_system", self, "_on_star_system_view")

func _on_star_system_view(system_data):
	$MainCamera.set_position(system_data.get_global_position())
