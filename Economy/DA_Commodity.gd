extends DA_Item
class_name DA_Commodity

var COMMODITY_TYPE = DA_RawItem.COMMODITY_TYPE

var _type = null

func _init(n, n_id, type).(n, n_id):
	set_type(type)

func set_type(type) -> bool:
	if COMMODITY_TYPE.values().has(type):
		_type = type
		return true
	return false

func get_type():
	for t in COMMODITY_TYPE:
		if _type == COMMODITY_TYPE[t]:
			return t
	return "NO_TYPE_AVAILABLE"


