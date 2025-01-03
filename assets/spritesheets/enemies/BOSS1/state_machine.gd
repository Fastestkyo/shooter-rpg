extends Node2D

var current_state:Statee
var previous_state:Statee

func _ready() -> void:
	current_state = get_child(0) as Statee
	previous_state = current_state
	current_state.enter()

func change_state(state):
	current_state = find_child(state) as Statee
	current_state.enter()
	
	previous_state.exit()
	previous_state = current_state
