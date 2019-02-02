extends StaticBody2D

var ResourceTypes = [
	"Coal",
	"Metal_Ore",
	"Organics",
	"Food"
]

var StructureTypes = {
	"Mine": {
		"Product": "Coal",
		"Basic_Amount": 5
	},
	"Ore_Mine": {
		"Product": "Metal_Ore",
		"Basic_Amount": 3
	},
	"Farm": {
		"Product": "Organics",
		"Basic_Amount": 5
	},
	"Food_Factory": {
		"Product": "Food",
		"Required": {
			"Resource": "Organics",
			"Basic_Amount": 6
		},
		"Basic_Amount": 2
	}
}

class CResource:
	var _name = null setget set_name, get_name
	
	func set_name(name):
		_name = name
	
	func get_name():
		return _name

class CStructure:
	var _name = null
	var _product_name = null
	var _product_amount = null
	var _production_time = null
	var _owner = null

var _storage = {}
var _structures = []
var _owner = null
var _name = null

signal highlight()

func _ready():
	connect("highlight", self, "_on_Planet_highlight")

func _unhandled_input(event):
	pass

func deselect():
	$Highlight.hide()

func _on_Planet_input_event(viewport, event, shape_idx):
	pass

func _on_Planet_highlight():
	if not $Highlight.is_visible_in_tree():
		$Highlight.show()