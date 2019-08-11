extends Node2D

var resources_file = "res://Resources/"

func _ready():
	initialize_items()

func initialize_items():
	var raw_minerals = get_files_in_directory(resources_file)
	for i in raw_minerals:
		create_commodity(resources_file + i)

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

func create_commodity(r_m_path: String):
	var c_list = global._commodity_list
	var c_obj = load(r_m_path)
	var c = DA_Commodity.new(c_obj._name, c_obj._name_id, c_obj._type)
	c_list.append(c)

func _on_Timer_timeout():
	pass
