extends Node2D

var _auction_house = AuctionHouse.new()

func _ready():
	randomize()
	_auction_house.set_name("auction_house")
	add_child(_auction_house)
	_auction_house.start()

func _on_Timer_timeout():
	_auction_house.tick()
