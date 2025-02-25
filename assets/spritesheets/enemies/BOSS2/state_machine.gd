extends Node2D

var current_state:Boss2_State
var previous_state:Boss2_State

func _ready() -> void:
	current_state = get_child(0) as Boss2_State
	previous_state = current_state
	current_state.enter()

func change_state(state):
	current_state = find_child(state) as Boss2_State
	current_state.enter()
	
	previous_state.exit()
	previous_state = current_state
