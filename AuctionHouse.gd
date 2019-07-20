extends Node
class_name AuctionHouse

class Trades:
	var _list: Array
	
	func add(trade: Trade):
		_list.append(trade)
	
	func remove_at(index: int):
		_list.remove(index)
	
	func get_list():
		return _list
	
	func shuffle():
		_list.shuffle()

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
		return _list

var _tick_interval = 0.1
var _num_agents: int = 100
var _init_cash: float = 100
var _init_stock: float = 15
var _max_stock: float = 20
var _agents: Array = []
var _ask_table: TradeTable
var _bid_table: TradeTable
var _last_tick: float = 0

var _commodities: Commodities
var tax_array = []

func _init():
	_commodities = Commodities.new()
	_ask_table = TradeTable.new()
	_bid_table = TradeTable.new()

func start():
	var _types = ["Food", "Wood", "Metal", "Ore", "Tool"]
	for i in range(5):
		var agent = MarketAgent.new()
		init_agent(agent, _types[i])

func init_agent(agent: MarketAgent, type: String):
	var buildables: PoolStringArray
	var init_stock: float
	var max_stock: float
	
	agent._id += 1
	buildables.append(type)
	init_stock = rand_range(_init_stock / 2.0, _init_stock * 2.0)
	max_stock = max(_init_stock, _max_stock)
	
	agent.init(_init_cash, buildables, init_stock, max_stock)
	_agents.append(agent)

func fixed_update():
	tick()

func tick():
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
		
		var switch_based_on_num_bids = true
		if switch_based_on_num_bids:
			for i in asks:
				print(i.print_info())
	





