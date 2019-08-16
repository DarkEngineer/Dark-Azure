extends Node2D

func _ready():
	pass

func _on_Timer_timeout():
	global.emit_signal("month_passed")
