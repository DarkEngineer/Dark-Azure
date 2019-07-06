extends Control

onready var _tree = $Box/Rows/Tree

func _ready():
	fill_tree_columns()

func fill_tree_columns():
	var root = _tree.create_item()
	root.set_text(0, "Name")
	root.set_text(1, "Amount")
	root.set_text(2, "Value")
	var list = _tree.create_item(root)
	list.set_text(0, "Coal")
	list.set_text(1, "22")
	list.set_text(2, "2.45")