extends Node


func _ready():
	randomize()

func load_JSON_file(file_path) -> Dictionary:
	var file = File.new()
	file.open(file_path, File.READ)
	var data_text = file.get_as_text()
	file.close()
	var data_json = JSON.parse(data_text)
	if data_json.error == OK:
		var data = data_json.result
		return data
	else:
		printerr("ERROR: %s JSON file error, try file validation to find errors" % [file_path])
	return {"JSON_error": data_json.error_string}
