extends Control

var Star_System_Name = preload("res://GalaxyUI/StarSystemName.tscn")

func _ready():
	pass

func update_galaxy_stars_ui():
	var cam_zoom = global._main_camera_current_zoom
	var text_visibility_zoom_limit = 10.0
	
	if cam_zoom > text_visibility_zoom_limit and $Stars.is_visible_in_tree():
		hide_stars_ui()
	elif cam_zoom <= text_visibility_zoom_limit and cam_zoom >= 0.0 and not $Stars.is_visible_in_tree():
		show_stars_ui()

func create_star_systems_text():
	var t_pos_array = get_tree().get_nodes_in_group("Star Text Positions")
	for t_pos in t_pos_array:
		var g_star = t_pos.get_parent()
		create_star_name_text(g_star.get_name(), g_star.get_id(), t_pos.get_global_position())

func create_star_name_text(n, g_star_id, pos):
	var star_name = Star_System_Name.instance()
	star_name.set_name("StarSystemName_%d" % [g_star_id])
	star_name.set_position(pos)
	star_name.set_text(n)
	$Stars.add_child(star_name)
	correct_star_system_text_position(star_name)

func correct_star_system_text_position(s_obj):
	var size = s_obj.get_size()
	var correction_x = size.x / 2.0
	var new_pos = s_obj.get_position() + Vector2(-correction_x, 0)
	s_obj.set_position(new_pos)

func show_stars_ui():
	$Stars.show()

func hide_stars_ui():
	$Stars.hide()

func _on_UpdateUITimer_timeout():
	update_galaxy_stars_ui()
