extends KinematicBody2D

const DISTANCE_THRESHOLD = 3.0
const ARRIVE_THRESHOLD = 3.0

# warning-ignore:unused_class_variable
var _default_mass = 50.0

# warning-ignore:unused_class_variable
var _max_speed = 400.0
# warning-ignore:unused_class_variable
var _slow_radius = 200.0
# warning-ignore:unused_class_variable
var _follow_offset = 120.0
# warning-ignore:unused_class_variable
var _mass = 20.0


var _target = null
var _target_global_position: Vector2 = Vector2.ZERO

# warning-ignore:unused_class_variable
var _velocity: Vector2 = Vector2.ZERO

# warning-ignore:unused_class_variable
onready var _sprite = $Sprite
# warning-ignore:unused_class_variable
onready var _collision_shape = $CollisionShape
onready var _state_machine = $StateMachine

func _ready():
	pass

func start_move(t_global_pos, target = null):
	_target_global_position = t_global_pos
	_target = target
	
	_state_machine._change_state("move")

func start_follow(t_global_pos, target = self):
	_target_global_position = t_global_pos
	_target = target
	
	_state_machine._change_state("follow")
