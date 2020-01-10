extends "res://src/StateMachine/StateMachine.gd"


func _ready():
	states_map = {
		"idle": $Idle,
		"system_jump": $SystemJump,
		"move": $Move
	}

func _change_state(state_name):
	"""
	The base state_machine interface this node extends does most of the work
	"""
	if not _active:
		return
	"""
	if state_name in ["move", "follow"]:
		states_stack.push_front(states_map[state_name])
	"""
	if state_name in ["system_jump", "move"]:
		if current_state == states_map[state_name]:
			states_stack.pop_front()
		states_stack.push_front(states_map[state_name])
	._change_state(state_name)

# warning-ignore:unused_argument
func _input(event):
	"""
	Here we only handle input that can interrupt states, attacking in this case
	otherwise we let the state node handle it
	"""

func start_system_jump(target_pos):
	_change_state("system_jump")
	$SystemJump.set_jump_target(target_pos)
