extends Control

func _ready():
	pass

func set_pop_quantity(value: float):
	var p_value = $Population/Grid/PopValue
	p_value.set_text(str(int(value)))

func set_growth_rate(value: float):
	var g_value = $Population/Grid/GrowthValue
	var t_value = value * 100
	g_value.set_text("%.2f percent" % [t_value])

func set_consumption_value(value: float):
	var c_value = $Population/Grid/ConsValue
	c_value.set_text(str(value))

func set_population_info(data: Dictionary):
	set_pop_quantity(data.pop_quantity)
	set_growth_rate(data.growth_rate)
	set_consumption_value(data.consumption_value)