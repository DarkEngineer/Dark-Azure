extends Node

var _offers = []

func add_offer(offer_data):
	_offers.append(offer_data)

func remove_offer(offer):
	_offers.erase(offer)
