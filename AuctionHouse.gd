extends Node
class_name AuctionHouse

var Chart = preload("res://FlowChart/FlowChart.tscn")

class Trades:
	class SortTechnique:
		static func sort_inc(a: Trade, b: Trade):
			if a._price < b._price:
				return true
			return false
		
		static func sort_dec(a: Trade, b: Trade):
			if b._price < a._price:
				return true
			return false
	
	var _list: Array
	
	func add(trade: Trade):
		_list.append(trade)
	
	func remove_at(index: int):
		_list.remove(index)
	
	func get_list():
		return _list
	
	func shuffle():
		_list.shuffle()
	
	func sort_inc():
		get_list().sort_custom(SortTechnique, "sort_inc")
	
	func sort_dec():
		get_list().sort_custom(SortTechnique, "sort_dec")
	
	func sum_quantity():
		var sum: float = 0
		for i in get_list():
			sum += i._quantity
		return sum

class TradeTable:
	var _list: Dictionary setget , get_list
	
	func add(ts: TradeSubmission):
		var ts_list = ts.get_list()
		for entry in ts_list:
			var commodity = entry
			var trade = ts_list[entry]
			_list[entry] = Trades.new()
			_list[entry].add(trade)
	
	func get_list():
		return _list # [string] = Trades

var _tick_interval = 0.1
var _num_agents: int = 100
var _init_cash: float = 100
var _init_stock: float = 15
var _max_stock: float = 20
var _agents: Array = []
var _ask_table: TradeTable
var _bid_table: TradeTable
var _last_tick: float = 0

var _defaulted = 0
var _irs_tax = 0

var _commodities: Commodities
var tax_array = []

var _track_bids: Dictionary = {}

var _chart

func _init():
	_commodities = Commodities.new()
	_ask_table = TradeTable.new()
	_bid_table = TradeTable.new()
	_chart = Chart.instance()
	_chart.set_name("chart_1")
	add_child(_chart)

func start():
	var _types = ["Food", "Wood", "Metal", "Ore", "Tool"]
	for i in range(100):
		var agent = MarketAgent.new()
		init_agent(_commodities, agent, _types[randi() % 5])
	
	for entry in _commodities.get_list():
		_track_bids[entry] = Dictionary()
		for item in _commodities.get_list():
			_track_bids[entry][item] = 0
		

func init_agent(market_commodities: Commodities, agent: MarketAgent, type: String):
	var buildables: PoolStringArray
	var init_stock: float
	var max_stock: float
	
	agent._id += 1
	buildables.append(type)
	init_stock = rand_range(_init_stock / 2.0, _init_stock * 2.0)
	max_stock = max(_init_stock, _max_stock)
	
	agent.init(market_commodities, _init_cash, buildables, init_stock, max_stock)
	_agents.append(agent)

func fixed_update():
	tick()

func tick():
	var c_list = _commodities.get_list()
	var average_price: float
	# get all agents' asks and bids
	for agent in _agents:
		_ask_table.add(agent.produce(_commodities, tax_array)) 
		_bid_table.add(agent.consume(_commodities))
	
	# resolve prices
	for entry in _commodities.get_list():
		var money_exchanged = 0
		var goods_exchanged = 0
		var asks = _ask_table.get_list()[entry].get_list()
		var bids = _bid_table.get_list()[entry].get_list()
		var demand = bids.size()
		
		var asks_trades: Trades = _ask_table.get_list()[entry]
		var bids_trades: Trades = _bid_table.get_list()[entry]
		
		var fail_safe = 0
		
		var switch_based_on_num_bids = true
		if switch_based_on_num_bids:
			var num_bids = bids_trades.sum_quantity()
			var num_asks = asks_trades.sum_quantity()
			c_list[entry]._bids.add(num_bids)
			c_list[entry]._asks.add(num_asks)
		else:
			c_list[entry]._asks.add(asks.size())
			c_list[entry]._bids.add(bids.size())
		
		asks_trades.shuffle()
		bids_trades.shuffle()
		
		asks_trades.sort_inc()
		bids_trades.sort_dec()
		
		while asks.size() > 0 and bids.size() > 0:
			var ask_index = 0
			var ask = asks[ask_index]
			var bid_index = 0
			var bid = bids[bid_index]
			
			#set price
			var clearing_price = (bid._price + ask._price) / 2.0
			var trade_quantity = min(bid._quantity, ask._quantity)
			var bought_quantity = bid._agent.buy(entry, trade_quantity, clearing_price)
			ask._agent.sell(entry, bought_quantity, clearing_price)
			var buyers = _track_bids[entry]
			
			if ask.reduce(bought_quantity) == 0:
				asks_trades.remove_at(ask_index)
				fail_safe = 0
			if bid.reduce(bought_quantity) == 0:
				bids_trades.remove_at(bid_index)
				fail_safe = 0
			fail_safe += 1
			if fail_safe > 1000:
				asks_trades.remove_at(ask_index)
			
			money_exchanged += clearing_price * bought_quantity
			goods_exchanged += bought_quantity
		
		if goods_exchanged == 0:
			goods_exchanged = 1
		elif goods_exchanged < 0:
			print_debug("ERROR - %s had negative exchanges" % [entry])
		
		average_price = money_exchanged / goods_exchanged
		
		c_list[entry]._trades.add(goods_exchanged)
		c_list[entry]._prices.add(average_price)
		
		for ask in asks:
			ask._agent.reject(entry, average_price)
		
		for bid in bids:
			bid._agent.reject(entry, average_price)
		
		bids.clear()
		
		c_list[entry].update(average_price, demand)
		
		if entry == "Food":
			set_graph(_chart, entry, average_price)
		

func enact_bankruptcy():
	for agent in _agents:
		if agent.is_bankrupt():
			_defaulted += agent._cash
		
		_irs_tax -= agent.tick()

func count_stock_pile_and_cash():
	var stock_pile: Dictionary = {}
	var stock_list: Dictionary = {}
	var cash_list: Dictionary = {}
	var total_cash: float = 0
	for entry in _commodities.get_list():
		stock_pile[entry] = 100
		stock_list[entry] = PoolRealArray()
		cash_list[entry] = PoolRealArray()
	
	for agent in _agents:
		var agent_sp = agent._stock_pile
		for c in agent_sp:
			stock_pile[c] += agent_sp[c].surplus()
			var surplus = agent_sp[c].surplus()
			
			stock_list[c].append(surplus)
		cash_list[agent._buildables[0]].append(agent._cash)
		total_cash += agent._cash 

func set_graph(graph_obj, type = "Food", value = 0):
	print(value)
	graph_obj.tick(value)