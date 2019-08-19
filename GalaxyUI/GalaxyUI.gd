extends Control

func _ready():
	pass

func update_galaxy_stars_ui():
	pass

func create_star_systems_text():
	var t_pos_array = get_tree().get_nodes_in_group("Star Text Positions")
	for t_pos in t_pos_array:
		var g_star = t_pos.get_parent()
		create_star_name_text(g_star.get_name(), g_star.get_id(), t_pos.get_global_position())

func create_star_name_text(n, g_star_id, pos):
	var star_name = Label.new()
	star_name.set_name("StarSystemName_%d" % [g_star_id])
	star_name.set_position(pos)
	star_name.set_text(n)
	$Stars.add_child(star_name)