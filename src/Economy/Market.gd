extends Node

class Offer:
	var _quantity = 0
	var _price = 0
	
	func set_data(amount, price):
		_quantity = amount
		_price = price

class Trader:
	var _inventory = []
	var _price_mean = 2.0
	var _price_min = 0.5
	var _price_max = 4.5
	var _buyer = false
	
	func offer_product(offer_list: Array, amount):
		var offer = Offer.new()
		var price = rand_range(_price_min, _price_max)
		offer.set_data(amount)
		offer_list.append(offer)
		

var _offers = []

func create_trader():
	var sellers = 5
	var buyers = 4
	var trader = Trader.new()
	
	

func buy_offer():
	var rand_index = randi() % _offers.size()
	print("Bought %s" % [str(_offers[rand_index])])
	
	show_demand(_offers[rand_index]._quantity)
	_offers.remove(rand_index)
	

func show_demand(amount_bought = 0.0):
	var product_quantity = 0
	for offer in _offers:
		product_quantity += offer._quantity
	if product_quantity > 0:
		var demand = float(amount_bought) / float(product_quantity)
		print("Sold: %d, Available: %d, Demand: %f" % [amount_bought, product_quantity, demand])

func _on_Timer_timeout():
	var chance = randf()
	if chance >= 0.3:
		buy_offer()
