extends Node2D

var _auction_house = AuctionHouse.new()

func _ready():
	_auction_house.start()

func _on_Timer_timeout():
	_auction_house.fixed_update()
