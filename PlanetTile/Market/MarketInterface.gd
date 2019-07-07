extends Panel

onready var _product_list = $Margin/VBox/MarketTabs/Offers/MarginLeft/ProductList

var _minerals = ["Coal"]

func _ready():
	show_products()

func show_products():
	var root = _product_list.create_item()
	root.set_text(0, "Raw Minerals")
	for obj in _minerals:
		var products = _product_list.create_item(root)
		products.set_text(0, obj) 