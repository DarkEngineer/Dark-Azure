extends Panel

onready var _product_list = $Margin/VBox/MarketTabs/Offers/MarginLeft/ProductList
onready var _sell_list = $Margin/VBox/MarketTabs/Offers/MarginRight/RightVBox/TabContainer/Offers/OfferVBox/SellOrders
onready var _buy_list = $Margin/VBox/MarketTabs/Offers/MarginRight/RightVBox/TabContainer/Offers/OfferVBox/BuyOrders

var _minerals = ["Coal"]

class SortOrder:
	static func bubble_sort(a, b):
		if a.get_price() < b.get_price():
			return true
		return false

func _ready():
	show_products()

func show_products():
	var root = _product_list.create_item()
	root.set_text(0, "Raw Minerals")
	for obj in _minerals:
		var products = _product_list.create_item(root)
		products.set_text(0, obj) 

func update_sell_orders(sell_orders):
	var root = _sell_list.get_root()
	if root as TreeItem:
		root.free()
	var titles = _sell_list.create_item()
	titles.set_text(0, "Quantity")
	titles.set_text(1, "Price")
	bubble_sort_by_price(sell_orders)
	for order in sell_orders:
		var order_cell = _sell_list.create_item(titles)
		order_cell.set_text(0, str(order.get_amount()))
		order_cell.set_text(1, str(order.get_price()))

func update_buy_orders(buy_orders):
	var root = _buy_list.get_root()
	if root as TreeItem:
		root.free()
	var titles = _buy_list.create_item()
	titles.set_text(0, "Quantity")
	titles.set_text(1, "Price")
	bubble_sort_by_price(buy_orders)
	for order in buy_orders:
		var order_cell = _buy_list.create_item(titles)
		order_cell.set_text(0, str(order.get_amount()))
		order_cell.set_text(1, str(order.get_price()))

func bubble_sort_by_price(order_array: Array):
	order_array.sort_custom(SortOrder, "bubble_sort")