extends PanelContainer


func _ready():
	pass

func refresh_offer():
	show_list()

func show_list():
	
	var list = $Market.get_list()
	var showlist = $MarginContainer/HBoxContainer/TabContainer/Offers/Tree
	showlist.clear()
	showlist.set_hide_root(true)
	showlist.set_column_titles_visible(true)
	showlist.set_column_title(0, "Quantity")
	showlist.set_column_title(1, "Price")
	
	showlist.create_item()
	
	for offer in list:
		show_offer(showlist, offer.get_quantity(), offer.get_price())
	
func show_offer(list: Tree, amount, price):
	var item = list.create_item(list.get_root())
	item.set_text(0, str(amount))
	item.set_text(1, "%f [Currency]" % [price])
	

func _on_RefreshOffer_pressed():
	refresh_offer()
