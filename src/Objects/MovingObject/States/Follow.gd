extends "res://src/StateMachine/State.gd"

# warning-ignore:unused_argument
func update(delta):
	if owner._target == self:
		emit_signal("finished", "previous")
		return
	
	var target_global_position = owner._target.get_global_position()
	
	var to_target: Vector2 = owner.global_position.distance_to(target_global_position)
	
	if to_target < owner.ARRIVE_THRESHOLD:
		return
	
	var follow_global_position: Vector2
	
	if to_target > owner._follow_offset:
		follow_global_position = target_global_position - (target_global_position - 
				owner.global_position).normalized() * owner._follow_offset
	else:
		follow_global_position = owner.global_position
	
	owner._velocity = Steering.arrive_to(
		owner._velocity,
		owner.global_position,
		follow_global_position,
		owner._max_speed,
		owner._slow_radius,
		owner._mass
	)
	
	owner._velocity = owner.move_and_slide(owner._velocity)
	owner._sprite.rotation = owner._velocity.angle() + deg2rad(90)
	owner._collision_shape.rotation = owner._velocity.angle()
