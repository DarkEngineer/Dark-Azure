extends Resource
class_name PlanetStructure

enum STRUCTURE_TYPE {
	SOCIAL,
	INDUSTRIAL,
	MILITARY,
	RELIGION,
	CRIMINAL
}

export (String) var _name: String = "Default Structure"
export (String) var _name_id: String = "default_structure"
export (STRUCTURE_TYPE) var _structure_type: int

