extends Panel

onready var _logs = $Margin/VBox/Logs

func order_created(order: Order):
	_logs.add_text("Trader ID %d created order for %s - quantity %d for %.2f per unit" % [order.get_trader_id(), order.get_name(), order.get_amount(),
		order.get_price()])
	_logs.newline()