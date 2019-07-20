extends Node
class_name Commodities

class Dependency:
	# list structure - name: quantity
	var _list: Dictionary
	
	func add(n: String, q: float):
		if not _list.has(n):
			print("Can't find dependency %s in commodity" % [n])
		_list[n] = q
		print("New dependency %s - %d" % [n, q])
	
	func get_list() -> Dictionary:
		return _list

class Commodity:
	var _bids: ESList
	var _asks: ESList
	var _prices: ESList
	var _trades: ESList
	var _profits: ESList
	
	var _default_price = 1
	var _avg_price = 1
	var _first_avg_price = true
	
	var _name: String
	var _price: float
	var _demand: float
	var _production: float
	var _dependency: Dependency
	
	func _init(n, p, d):
		_name = n
		_production = p
		_price = _default_price
		_dependency = d
		_demand = 1
		_bids = ESList.new()
		_asks = ESList.new()
		_prices = ESList.new()
		_trades = ESList.new()
		_profits = ESList.new()
		_bids.add(1)
		_asks.add(1)
		_prices.add(1)
		_trades.add(1)
		_profits.add(1)
	
	func get_avg_price(history: int):
		if _first_avg_price:
			_first_avg_price = false
			var skip = max(0, _prices.get_size() - history)
			_avg_price = _prices.average(_prices.get_range(skip, _prices.get_size()))
		return _avg_price
	
	func get_dependency():
		return _dependency
	
	func update(price, demand):
		_first_avg_price = true
		_price = price
		_demand = demand


var _list: Dictionary

func _init():
	init_commodities()

func awake():
	init_commodities()

func init_commodities():
	print("Commodities initialization")
	
	var food_dep = Dependency.new()
	food_dep.add("Wood", 2)
	add("Food", 4, food_dep)
	
	var wood_dep = Dependency.new()
	wood_dep.add("Food", 3)
	wood_dep.add("Tool", 0.1)
	add("Wood", 2, wood_dep)
	
	var ore_dep = Dependency.new()
	ore_dep.add("Food", 4)
	add("Ore", 3, ore_dep)
	
	var metal_dep = Dependency.new()
	metal_dep.add("Food", 2)
	metal_dep.add("Ore", 3)
	add("Metal", 1, metal_dep)
	
	var tool_dep = Dependency.new()
	tool_dep.add("Food", 3)
	tool_dep.add("Metal", 1.5)
	add("Tool", 1, tool_dep) 

func get_list() -> Dictionary:
	return _list

func get_most_profitable_profession(history: int = 10) -> String:
	var prof: String = "invalid"
	var most: float = 0
	
	for entry in _list:
		var commodity = entry
		var profit_history: ESList = _list[entry].profits
		var profit = profit_history.last_average(history)
		
		if profit > most:
			prof = commodity
	
	return prof

func get_relative_demand(c: Commodity, history: int = 10) -> float:
	var average_price: float = c._prices.last_average(history)
	var min_price: float = c._prices.min()
	
	var price: float = c._prices._list[c._prices.get_size() - 1]
	var relative_demand: float = (price - min_price) / (average_price - min_price)
	
	return relative_demand

func get_hottest_good(history: int = 10) -> String:
	var most_demand: String = "invalid"
	var max_value: float = 1.1
	var most_rd_demand = "invalid"
	var max_rd = max_value
	for c in _list:
		var asks: float = c._asks.last_average(history)
		var bids: float = c._bids.last_average(history)
		asks = max(0.5, asks)
		var ratio: float = asks / bids
		var rel_demand = get_relative_demand(c, history)
		
		if max_rd < rel_demand:
			most_rd_demand = c._name
			max_rd = rel_demand
		
		if max_value < ratio:
			max_value = ratio
			most_demand = c._name
	
	return most_demand

func add(c_name: String, c_production: float, c_dep: Dependency):
	if _list.has(c_name):
		return false
	if c_dep != null:
		_list[c_name] = Commodity.new(c_name, c_production, c_dep)
	return true

func print_stat():
	for item in _list:
		print("Item %s: %f" % [])
		
		var item_dep = item.get_dependency()
		
		if item_dep != null:
			print("Dependencies: ")
			var item_dep_list = item_dep.get_list()
			for item_dep in item_dep_list:
				print(" -> %s: %f" % [item_dep, item_dep_list[item_dep]])



