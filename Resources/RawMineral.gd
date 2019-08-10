extends Resource
class_name DA_RawMineral

enum COMMODITY_TYPE {
	COMMON,
	RARE,
	UNIQUE,
	EPIC,
	LEGENDARY,
	GODLY,
	COSMIC
}

export (String) var _name: String
export (COMMODITY_TYPE) var _type
export (int) var _commodity_id: int
export (String) var _description: String

