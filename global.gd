extends Node


# Signals from Game to UI
########################
signal market_commodity_query(com_list_data)
########################
# Signals from UI to Game

########################

func _ready():
	randomize()

