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
			print("Bought too much! Max: %f ")
		else:
			left_over = 0
			
		#need to finish
	
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

var _debug: int = 0
var _cash: float setget set_cash, get_cash
var _previous_cash: float = 0
var _max_stock: float = 1
var _profits: ESList

var _stock_pile: Dictionary
var _stock_pile_cost: Dictionary

var _buildables: PoolStringArray # can produce commodities


var _commodities: Commodities #base implementation

func _init(o_init_cash: float, o_buildables: PoolStringArray, o_init_num: float = 5, o_max_stock: float = 10):
	_buildables = o_buildables
	_cash = o_init_cash
	_previous_cash = _cash
	_max_stock = o_max_stock
	for buildable in _buildables:
		if not _commodities.get_list().has(buildable):
			printerr("commodity not recognized: %s" % [buildable])
		
		if _commodities.get_list()[buildable].get_dependency() == null:
			printerr("%s: null dependency" % [buildable])
		
		for dep in _commodities.get_list()[buildable].get_dependency().get_list():
			var commodity = dep
			add_to_stock_pile(commodity, o_init_num, o_max_stock, _commodities.get_list()[commodity]._price, 
					_commodities.get_list()[commodity]._production)

func set_cash(value: float):
	_cash = value

func get_cash() -> float:
	return _cash

func start():
	_cash = 0

func add_to_stock_pile(o_name: String, o_num: float, o_max: float, o_price: float, o_production: float):
	if _stock_pile.has(o_name):
		return
	_stock_pile[o_name] = CommodityStock.new(o_name, o_num, o_max, o_price, o_production)
	
	_stock_pile_cost[o_name] = _commodities[o_name]._price * o_num

