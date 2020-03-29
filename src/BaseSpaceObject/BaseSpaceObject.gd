extends Area2D

var _minerals = []

var _material_list_path: String = "res://data/minerals/material_list.json"

func _ready():
	create_minerals_random(400, 50000)

func create_minerals_random(min_range: float, max_range: float):
	var m_json = global.load_JSON_file(_material_list_path)
	var m_list = m_json["material_list"]
	
	for m_obj in m_list:
		var r_quantity = rand_range(min_range, max_range)
		r_quantity = floor(r_quantity)
		var m_key = m_obj.keys().front()
		var id = m_obj[m_key]
		var obj = {
			m_key: {
				"id": id,
				"quantity": r_quantity
			}
		}
		_minerals.append(obj)
	
