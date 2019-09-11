extends Area2D

onready var _shape = $CollisionShape
onready var _timer = $GetTargetTimer

signal objects_targeted(target_array)

var _start_detection = false

func _ready():
	hide()

func _input(event):
	if event.is_action_pressed("right_mouse"):
		start_detect_target()
	if event.is_action_released("right_mouse"):
		end_detect_target()

func start_detect_target():
	set_monitorable(true)
	set_area_position(get_global_mouse_position())

func end_detect_target():
	show()
	_timer.start()

func set_area_position(pos: Vector2):
	set_position(pos)

func get_current_mouse_target() -> Array:
	var target_array = get_overlapping_areas()
	return target_array

func _on_GetTargetTimer_timeout():
	var objects = get_current_mouse_target()
	print(objects)
	emit_signal("objects_targeted", objects)
	set_monitorable(false)
	hide()
