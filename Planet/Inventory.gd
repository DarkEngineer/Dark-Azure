extends Tree

func _ready():
	create_tree_structure()

func create_tree_structure():
	var root = create_item()
	var t1 = create_item(root)
	t1.set_text(0, "Item Name")
	t1.set_text(1, "Quantity")
	t1.set_text(2, "Owned by")

func update_inventory():
	pass