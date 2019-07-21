extends Node
class_name MarketAgent

class History:
	var _list: Array
	
	var _min: float = 0
	var _max: float = 0
	
	func history_min():
		return _min
	
	func history_max():
		return _max
	
	func get_list():
		return _list
	
	func add(value: float):
		_list.append(value)
	
	func get_last():
		return _list.back()

class CommodityStock:
	var _commodity_name: String setget set_commodity_name, get_commodity_name
	var _significant: float = 0.25
	var _sig_imbalance: float = 0.33
	var _low_inventory: float = 0.1
	var _high_inventory: float = 2
	var _price_history: History
	var _cost: float = 1.0
	
	var _wobble: float = 0.02
	var _quantity: float
	var _max_quantity: float
	var _min_price_belief: float setget set_min_price_belief, get_min_price_belief
	var _max_price_belief: float
	var _mean_cost: float
	var _production: float
	var _production_rate: float = 1
	
	func _init(c_name: String, c_quantity: float = 1, c_max_quantity: float = 10, c_mean_price: float = 1, 
			c_production: float = 1):
		_price_history = History.new()
		
		set_commodity_name(c_name)
		_quantity = c_quantity
		_max_quantity = c_max_quantity
		set_min_price_belief(c_mean_price / 2.0)
		_max_price_belief = c_mean_price * 2.0
		_mean_cost = c_mean_price
		_price_history.add(c_mean_price)
		_production = c_production
		
	
	func set_commodity_name(value: String):
		_commodity_name = value
	
	func get_commodity_name():
		return _commodity_name
	
	func set_min_price_belief(value: float):
		_min_price_belief = value
	
	func get_min_price_belief():
		return _min_price_belief
	
	func surplus():
		return _quantity
	
	func deficit():
		var shortage = _max_quantity - _quantity
		return max(0, shortage)
	
	func tick():
		_price_history._min = _price_history.history_min()
		_price_history._max = _price_history.history_max()
	
	func buy(quant: float, price: float):
		var total_cost = _mean_cost * _quantity + price * quant
		_mean_cost = total_cost / _quantity
		var left_over = quant - deficit()
		_quantity += quant
		if left_over > 0:
			# Bought too much commodity
			print("Bought too much! Max: %f " % [left_over])
		else:
			left_over = 0
			
		update_price_belief(false, price)
		
		return quant
	
	func sell(quant: float, price: float):
		_quantity += quant
		update_price_belief(true, price)
	
	func get_price():
		sane_price_belief()
		var p = rand_range(_min_price_belief, _max_price_belief)
		return p
	
	func sane_price_belief():
		_min_price_belief = max(_cost * 0.9, _min_price_belief)
		_max_price_belief = max(_min_price_belief * 1.1, _max_price_belief)
		_min_price_belief = clamp(_min_price_belief, 0.1, 900)
		_max_price_belief = clamp(_max_price_belief, 1.1, 1000)
	
	func update_price_belief(c_sell: bool, c_price: float, c_success: bool = true):
		sane_price_belief()
		
		if _min_price_belief > _max_price_belief:
			assert(_min_price_belief < _max_price_belief)
		
		_price_history.add(c_price)
		
		var c_buy = not c_sell
		
		var mean = (_min_price_belief + _max_price_belief) / 2.0
		var delta_mean = mean - c_price # maybe modify to take account to market mean price
		
		if c_success:
			if (c_sell && delta_mean < -_significant * mean #undersold
				|| c_buy && delta_mean > _significant * mean): #overpaid
				_min_price_belief -= delta_mean / 4.0
				_max_price_belief -= delta_mean
			
			_min_price_belief += _wobble * mean
			_max_price_belief -= _wobble * mean
			
			if _min_price_belief > _max_price_belief:
				var avg = (_min_price_belief + _max_price_belief) / 2.0
				_min_price_belief = avg * (1 - _wobble)
				_max_price_belief = avg * (1 + _wobble)
			
			_wobble /= 2.0
		else:
			_min_price_belief -= delta_mean / 4.0 #shift toward mean
			_max_price_belief -= delta_mean / 4.0
		
		if _min_price_belief < _max_price_belief:
			_min_price_belief = _max_price_belief / 2.0
			sane_price_belief()

var _id: int = 0
var _cash: float setget set_cash, get_cash
var _previous_cash: float = 0
var _max_stock: float = 1
var _profits: ESList
var _identity: String = "market_agent_default"

var _stock_pile: Dictionary # list of CommodityStocks
var _stock_pile_cost: Dictionary

var _buildables: PoolStringArray # can produce commodities

var _bankruptcy_threshold: float = -20000

var _history_count: int = 10


var _commodities: Commodities #base implementation

"""
func _init(o_init_cash: float, o_buildables: PoolStringArray, o_init_num: float = 5, o_max_stock: float = 10):
	init(o_init_cash, o_buildables, o_init_num, o_max_stock)
"""
func init(market_commodities: Commodities, o_init_cash: float, o_buildables: PoolStringArray, o_init_num: float = 5, o_max_stock: float = 10):
	_buildables = o_buildables
	_cash = o_init_cash
	_previous_cash = _cash
	_max_stock = o_max_stock
	_commodities = market_commodities
	for buildable in _buildables:
		if not _commodities.get_list().has(buildable):
			printerr("commodity not recognized: %s" % [buildable])
		
		if _commodities.get_list()[buildable].get_dependency() == null:
			printerr("%s: null dependency" % [buildable])
		
		for dep in _commodities.get_list()[buildable].get_dependency().get_list():
			var commodity = dep
			add_to_stock_pile(commodity, o_init_num, o_max_stock, _commodities.get_list()[commodity]._price, 
					_commodities.get_list()[commodity]._production)
		
		add_to_stock_pile(buildable, 0, o_max_stock, _commodities.get_list()[buildable]._price,
				_commodities.get_list()[buildable]._production)

func set_cash(value: float):
	_cash = value

func get_cash() -> float:
	return _cash

func get_identity_name():
	return _identity

func start():
	_cash = 0

func add_to_stock_pile(o_name: String, o_num: float, o_max: float, o_price: float, o_production: float):
	if _stock_pile.has(o_name):
		return
	_stock_pile[o_name] = CommodityStock.new(o_name, o_num, o_max, o_price, o_production)
	
	_stock_pile_cost[o_name] = _commodities.get_list()[o_name]._price * o_num

func tax_profit(tax_rate: float):
	var profit = get_profit()
	if profit <= 0:
		return profit
	var tax_amount = profit * tax_rate
	_cash -= tax_amount
	return profit - tax_amount

func get_profit():
	var profit = _cash - _previous_cash
	_previous_cash = _cash
	return profit

func is_bankrupt():
	return _cash < _bankruptcy_threshold

func tick(market_commodities: Commodities):
	var tax_consumed: float = 0
	var starving: bool = false
	
	if _stock_pile.has("Food"):
		_stock_pile["Food"]._quantity -= 0.1
		starving = false
	
	for entry in _stock_pile:
		entry.tick()
	
	if is_bankrupt() or starving == true:
		tax_consumed = change_profession(market_commodities)
	
	for buildable in _buildables:
		_stock_pile[buildable]._cost = get_cost_of(buildable)
	
	return tax_consumed

func get_cost_of(commodity: String):
	var cost: float = 0
	var com_dep = _commodities.get_list()[commodity].get_dependency().get_list()
	for dep in com_dep:
		var dep_commodity = dep
		var num_dep = com_dep[dep]
		var dep_cost = _stock_pile[dep_commodity]._price_history.get_last()
		cost += num_dep * dep_cost
	
	return cost

func change_profession(market_commodities: Commodities):
	var best_good = _commodities.get_hottest_good(10)
	var best_prof = _commodities.get_most_profitable_profession(10)
	
	var most_demand = best_prof
	if best_good != "invalid":
		most_demand = best_good
	
	assert(_buildables.size() == 1)
	_buildables[0] = most_demand
	_stock_pile.clear()
	var b: PoolStringArray
	b.append(most_demand)
	var init_cash: float = 100
	init(market_commodities, init_cash, b)
	return init_cash

func buy(commodity: String, quantity: float, price: float):
	var bought_quantity = _stock_pile[commodity].buy(quantity, price)
	_cash -= price * bought_quantity
	return bought_quantity

func sell(commodity: String, quantity: float, price: float):
	_stock_pile[commodity].sell(-quantity, price)
	
	_cash += price * quantity

func reject_ask(commodity: String, price: float):
	_stock_pile[commodity].update_price_belief(true, price, false)

func reject_bid(commodity: String, price: float):
	_stock_pile[commodity].update_price_beleif(false, price, false)

func find_sell_count(c: String):
	var avg_price = _commodities.get_list()[c].get_avg_price(_history_count)
	var lowest_price = _stock_pile[c]._price_history.history_min()
	var highest_price = _stock_pile[c]._price_history.history_max()
	var favorability = inverse_lerp(lowest_price, highest_price, avg_price)
	var num_asks: float
	
	favorability = clamp(favorability, 0, 1)
	num_asks = favorability * _stock_pile[c].surplus()
	num_asks = max(1, num_asks)
	
	return num_asks

func find_buy_count(c: String):
	var avg_price = _commodities.get_list()[c].get_avg_price(_history_count)
	var lowest_price = _stock_pile[c]._price_history.history_min()
	var highest_price = _stock_pile[c]._price_history.history_max()
	var favorability = inverse_lerp(lowest_price, highest_price, avg_price)
	var num_bids: float
	
	favorability = clamp(favorability, 0, 1)
	num_bids = (1 - favorability) * _stock_pile[c].deficit()
	num_bids = max(1, num_bids)
	
	return num_bids

func consume(commodity_list):
	var bids = TradeSubmission.new()
	
	for stock in _stock_pile:
		if Array(_buildables).has(stock):
			continue
		
		var num_bids = find_buy_count(stock)
		
		if num_bids > 0:
			var buy_price = _stock_pile[stock].get_price()
			
			bids.add(stock, Trade.new(_stock_pile[stock].get_commodity_name(), buy_price, num_bids, self))
	
	return bids

func produce(commodities, tax_array: Array):
	var asks = TradeSubmission.new()
	
	for buildable in _buildables:
		var num_produced = 0
		var s_stock = ", has in stock"
		var dep_list = commodities.get_list()[buildable].get_dependency().get_list()
		var upper_bound
		
		if not commodities.get_list().has(buildable):
			print("not a commodity: %s" % [buildable])
		
		for dep in dep_list:
			var num_needed = dep_list[dep]
			var num_avail = _stock_pile[dep]._quantity
			num_produced = max(num_produced, num_avail / num_needed)
		
		upper_bound = min(_stock_pile[buildable]._production_rate, _stock_pile[buildable].deficit())
		num_produced = clamp(num_produced, 0, upper_bound)
		
		for dep in dep_list:
			var stock = _stock_pile[dep]._quantity
			var num_used = dep_list[dep] * num_produced
			num_used = clamp(num_used, 0, stock)
		
		num_produced *= _stock_pile[buildable]._production
		num_produced = max(num_produced, 0)
		_stock_pile[buildable]._quantity += num_produced
		
		var build_stock = _stock_pile[buildable]
		var sell_price = find_sell_count(buildable)
		build_stock.get_price()
		
		if num_produced > 0 and sell_price > 0:
			asks.add(buildable, Trade.new(buildable, sell_price, build_stock._quantity, self))
		else:
			pass
			"""
			idleTax = Mathf.Abs(cash*.05f);
			cash -= idleTax;
			"""
	
	return asks


