extends Node2D

onready var _planet = $Planet

func _ready():
	pass


func _on_Timer_timeout():
	_planet.planet_update()
