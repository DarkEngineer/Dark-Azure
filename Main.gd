extends Node2D

var resources_folder = "res://Resources/"
var structures_folder = "res://Structures"
var structure_blueprints_folder = "res://StructureBlueprints"

func _ready():
	initialize_raw_resources(resources_folder)
	initialize_structures(structures_folder)

func initialize_raw_resources(r_folder):
	var raw_minerals = get_files_in_directory(r_folder)
	for i in raw_minerals:
		create_commodity_template(r_folder + i)

func initialize_structures(s_folder):
	var structures = get_files_in_directory(s_folder)
	for i in structures:
		create_structure_template(s_folder + i)

func get_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file: String = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			if file.ends_with(".tres"):
				files.append(file)
	
	return files

func create_commodity_template(r_m_path: String):
	var c_list = global._commodity_list
	var c_obj = load(r_m_path)
	var c = DA_Commodity.new(c_obj._name, c_obj._name_id, c_obj._type)
	c_list.append(c)

func create_structure_template(s_path: String):
	var s_list = global._structure_list
	var s_obj = load(s_path)
	var s = R_Structure.new()

func _on_Timer_timeout():
	pass
