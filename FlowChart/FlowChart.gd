extends PanelContainer

const _graphs: int = 5

onready var _graph = $Panel/Line2D
onready var _panel = $Panel

var _space_between_data: float = 5

var _data_points_limit

var _graph_x_axis

onready var _x_first_value = $Panel/TitleVBox/XAxisMargin/XAxisHBox/XFirstValue
onready var _x_last_value = $Panel/TitleVBox/XAxisMargin/XAxisHBox/XLastValue

func _ready():
	set_x_axis()
	set_point_limit()

func create_new_data(data_name, color):
	pass

func set_x_axis():
	_graph_x_axis = _panel.get_rect().size.y

func set_point_limit():
	var graph_width: float = _panel.get_rect().size.x
	_data_points_limit = (graph_width / _space_between_data) - 1

func set_x_first(value: int):
	_x_first_value.set_text(str(value))

func set_x_last(value: int):
	_x_last_value.set_text(str(value))

func add_points(value, data_name, space_data, _data_limit):
	var graph_count = _graph.get_point_count()

	var graph_value = _graph_x_axis - value
	var graph_point_pos = Vector2(graph_count * _space_between_data, graph_value)
	_graph.add_point(graph_point_pos)
	correct_point_position(_space_between_data, graph_count)

func correct_point_position(space_data, graph_count):
	if graph_count > _data_points_limit:
		_graph.remove_point(0)
		for i in range(graph_count):
			var point_pos = _graph.get_point_position(i)
			_graph.set_point_position(i, Vector2( point_pos.x - _space_between_data, point_pos.y))
		

func tick(input):
	add_points(input, "Food",  _space_between_data, _data_points_limit)
