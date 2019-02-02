extends "res://ship/StateMachine.gd"

func _ready():
	states_map = {
		"idle": $Idle,
		"move": $Move,
		"patrol": $Patrol,
		"attack": $Attack
	}
	START_STATE = "Idle"
	initialize(START_STATE)
	current_state = states_stack.front()

# function overload 
# change states behaviour function
func _change_state(state_name):
	if not _active:
		return
	if current_state == states_map["patrol"] and state_name in ["move"]:
		states_stack.pop_front()
	._change_state(state_name)

func _input(event):
	current_state.handle_input(event)
