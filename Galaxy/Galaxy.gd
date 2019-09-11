extends Node2D

var Galaxy_Star = preload("res://Galaxy/GalaxyStar/GalaxyStar.tscn")
var Galaxy_Geometrics = preload("res://Galaxy/GalaxyGeometrics/GalaxyGeometrics.tscn")
var Galaxy_UI = preload("res://GalaxyUI/GalaxyUI.tscn")
var Galaxy_Ship = preload("res://GalaxyUI/GalaxyShip.tscn")
var Select_Area = preload("res://Galaxy/SelectArea/SelectArea.tscn")
var Target_Area = preload("res://Galaxy/TargetArea/TargetArea.tscn")

const DEFAULT_STARS_AMOUNT = 200
const DEFAULT_RANGE: float = 15000.0
const DEFAULT_DISTANCE_BETWEEN_STARS: float = 450.0

var _next_star_id: int = 1
var _current_active_galaxy_ships = 0

var _selected = [] setget , get_selected

# References
var _galaxy_geometrics_ref = null

func _ready():
	randomize()
	create_galaxy()
	create_galaxy_geometrics()
	create_galaxy_ui()
	create_galaxy_ship()
	create_selection_area_object()
	create_target_area_object()

func set_star_id():
	var star_id = _next_star_id
	_next_star_id += 1
	return star_id

func create_galaxy():
	var stars_created = 0
	for i in range(DEFAULT_STARS_AMOUNT):
		var star = Galaxy_Star.instance()
		var if_far_enough = false
		while not if_far_enough:
			var r_angle = rand_range(0, 2 * PI)
			var r_distance = rand_range(0, DEFAULT_RANGE)
			
			var new_x = cos(r_angle) * r_distance
			var new_y = sin(r_angle) * r_distance
			if_far_enough = check_star_distance_from_others(Vector2(new_x, new_y), 
					DEFAULT_DISTANCE_BETWEEN_STARS)
			if if_far_enough:
				var new_id = set_star_id()
				star.set_position(Vector2(new_x, new_y))
				star.set_name("star_%d" % [new_id])
				star.set_id(new_id)
				add_child(star)

func check_star_distance_from_others(new_position: Vector2, 
		distance_between_stars: float = DEFAULT_DISTANCE_BETWEEN_STARS):
	var g_stars = get_tree().get_nodes_in_group("Galaxy Stars")
	for star in g_stars:
		var distance = new_position - star.get_position()
		if distance.length() < distance_between_stars:
			return false
	
	return true

func create_galaxy_geometrics():
	var g_geometry = Galaxy_Geometrics.instance()
	g_geometry.set_name("GalaxyGeometrics")
	_galaxy_geometrics_ref = g_geometry
	add_child(g_geometry)

func create_galaxy_ui():
	var g_ui = Galaxy_UI.instance()
	g_ui.set_name("GalaxyUI")
	add_child(g_ui)
	g_ui.create_star_systems_text()

func increase_galaxy_ship_count():
	_current_active_galaxy_ships += 1

func decrease_galaxy_ship_count():
	_current_active_galaxy_ships -= 1

func get_galaxy_ship_count():
	return _current_active_galaxy_ships

func create_galaxy_ship():
	var g_ship = Galaxy_Ship.instance()
	increase_galaxy_ship_count()
	g_ship.set_name("Galaxy_Ship_%d" % [get_galaxy_ship_count()])
	g_ship.set_galaxy_ref(self)
	g_ship.set_galaxy_geometrics_ref(_galaxy_geometrics_ref)
	add_child(g_ship)

func get_selected():
	return _selected.duplicate()

func create_selection_area_object():
	var s_area = Select_Area.instance()
	s_area.set_name("SelectArea")
	s_area.connect("objects_selected", self, "_on_objects_selected")
	add_child(s_area)

func create_target_area_object():
	var target_area = Target_Area.instance()
	target_area.set_name("TargetArea")
	target_area.connect("objects_targeted", self, "_on_objects_target_chosen")
	add_child(target_area)

func filter_by_selection_mode(obj_array, selection_mode) -> Array:
	var filtered_objects = []
	var single_groups: Array = global.get_select_filter().single
	var multi_groups: Array = global.get_select_filter().multiple
	if selection_mode == global.SELECTION_MODE.SINGLE:
		for obj in obj_array:
			filter_selection_mode_object(obj, filtered_objects, single_groups)
	elif selection_mode == global.SELECTION_MODE.MULTIPLE:
		for obj in obj_array:
			filter_selection_mode_object(obj, filtered_objects, multi_groups)
	return filtered_objects

func filter_selection_mode_object(obj, filtered_obj_array, selection_mode_groups: Array):
	var group_array = obj.get_groups()
	for group in group_array:
		if selection_mode_groups.has(group):
			filtered_obj_array.append(obj)
			break

func filter_selection(selected_array: Array, current_selection_array: Array) -> void:
	var to_unselection = []
	var duplicates = []
	var new_selection = []
	for new_obj in current_selection_array:
		if selected_array.has(new_obj):
			duplicates.append(new_obj)
			selected_array.erase(new_obj)
		else:
			if new_obj.has_method("set_selected"):
				new_obj.set_selected()
			new_selection.append(new_obj)
			
	to_unselection = selected_array
	for unselect_obj in to_unselection:
		if unselect_obj.has_method("set_deselected"):
			unselect_obj.set_deselected()
		_selected.erase(unselect_obj)

func filter_object_selection(obj_array, selection_mode):
	return filter_by_selection_mode(obj_array, selection_mode)

func _on_objects_selected(obj_array, selection_mode):
	var filtered_obj_array = filter_object_selection(obj_array, selection_mode)
	filter_selection(get_selected(), filtered_obj_array)

func _on_galaxy_ship_selected(ship):
	_selected.append(ship)

func _on_galaxy_ship_deselected(ship):
	_selected.erase(ship)

func _on_objects_target_chosen(obj_array):
	pass
