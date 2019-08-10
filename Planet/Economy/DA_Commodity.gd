extends DA_Item
class_name DA_Commodity

var _type = null

func set_type(type) -> bool:
	if COMMODITY_TYPE.has(type):
		_type = type
		return true
	return false

func get_type():
	for t in COMMODITY_TYPE:
		if _type == COMMODITY_TYPE[t]:
			return t
	return "NO_TYPE_AVAILABLE"


