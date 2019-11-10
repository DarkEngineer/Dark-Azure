extends "res://src/StateMachine/State.gd"

# warning-ignore:unused_argument
func update(delta):
	
	if owner.global_position.distance_to(owner._target_global_position) < owner.DISTANCE_THRESHOLD:
		emit_signal("finished", "previous")
		return
	
	owner._velocity = Steering.arrive_to(
		owner._velocity,
		owner.global_position,
		owner._target_global_position,
		owner._max_speed,
		owner._mass
	)
	
	owner._velocity = owner.move_and_slide(owner._velocity)
	
	owner._sprite.rotation = owner._velocity.angle() + deg2rad(90)
	owner._collision_shape.rotation = owner._velocity.angle()
