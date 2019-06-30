extends PanelContainer

var _buildings

func _ready():
	get_all_buildings_data()

func list_files_in_directory(path: String = "res://", extension: String = ""):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			if file.ends_with(extension):
				files.append(file)
		
	return files

func get_all_buildings_data():
	var folder_path = "res://PlanetTile/Field/buildings/"
	var extension_path = ".tres"
	var buildings_path = list_files_in_directory(folder_path, extension_path)
	for path in buildings_path:
		var struct: Building = load(folder_path + path)