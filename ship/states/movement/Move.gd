extends "res://ship/states/State.gd"

onready var speed_pid = owner.get_speed_pid()
var speed = 0.0

func update(delta):
	var pos = owner.get_global_position()
	var steering = owner.seek(pos, owner._target, Vector2(0, 0))
	owner.move_and_slide(steering.normalized() * owner._current_speed)
	owner.update()

