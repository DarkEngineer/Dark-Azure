extends "res://ship/states/State.gd"

func update(delta):
	patrol_system(delta)
	
func patrol_system(delta):
	var wander_vector = Vector2(0, 0)
	wander_vector = owner.wander(owner.get_global_position(), wander_vector, 50.0, 30.0)
	wander_vector = wander_vector.normalized()
	owner.move_and_collide(wander_vector * owner._speed * delta)
	