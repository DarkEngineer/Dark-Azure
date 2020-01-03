extends PopupPanel

onready var _obj_name = $VBox/ObjectName
onready var _obj_faction = $VBox/ObjectFaction
onready var _obj_details = $VBox/ObjectDetails

func _ready():
	set_physics_process(false)
	set_process(false)
# warning-ignore:return_value_discarded
	InterfaceManager.connect("tooltip_requested", self, "_show_tooltip")
# warning-ignore:return_value_discarded
	InterfaceManager.connect("tooltip_hidden", self, "_hide_tooltip")
	

func _process(_delta):
	set_position(get_viewport().get_mouse_position())

func _show_tooltip(object_data: Dictionary):
	_obj_name.set_text("%s, Type Unknown" % [object_data.name])
	_obj_faction.set_text("%s, State Unknown" % [object_data.faction])
	_obj_details.set_text("Data Unavailable...")
	set_process(true)
	popup()

func _hide_tooltip():
	set_process(false)
	hide()
