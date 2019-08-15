extends Area2D

var _population: DA_Population
var _company_list = []
var _syndicate_list = []
var _government: DA_Government

func _ready():
	pass

func create_population(number, funds, consumption):
	var pop = DA_Population.new(number, funds, consumption)
	_population = pop

func create_company(funds, workers_max, product, product_price, population_object):
	_company_list.append(DA_Company.new(funds, workers_max, product, product_price, population_object))

func create_syndicate(funds, gangsters):
	_syndicate_list.append(DA_Syndicate.new(funds, gangsters))

func create_government(funds, tax_rate):
	_government = DA_Government.new(funds, tax_rate)