extends Area2D

var _population: DA_Population


func _ready():
	create_population(150)

func create_population(quantity):
	_population = DA_Population.new(quantity)
	var p_gui = get_tree().get_nodes_in_group("PlanetGUI").front()
	_population.connect("month_changed", p_gui, "set_population_info")