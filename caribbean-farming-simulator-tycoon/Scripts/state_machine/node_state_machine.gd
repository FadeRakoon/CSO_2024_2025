class_name NodeStateMachine
extends Node

# for now the state machine is used to manage various player states: idle, walking, tilling, chopping, watering

@export var initial_node_state : NodeState
#used to define an initial state 

var node_states : Dictionary = {}
var current_node_state : NodeState
var current_node_state_name : String
var parent_node_name: String


func _ready() -> void:
	parent_node_name = get_parent().name
	#gets the name of the player node
	for child in get_children():
		if child is NodeState:
			node_states[child.name.to_lower()] = child
			child.transition.connect(transition_to)
		#state machine is a node in the player scene and all the player states are child nodes of it
		#loops through all the child nodes connects the transtion signal from the NodeState class and places the references to them along with their names in a dictionary
		
	if initial_node_state:
		initial_node_state._on_enter()
		#activates the initial node state if there is one
		
		current_node_state = initial_node_state
		current_node_state_name = current_node_state.name.to_lower()
		#initialises the current state


func _process(delta : float) -> void:
	if current_node_state:
		current_node_state._on_process(delta)
	#updates the current state visually every frame

func _physics_process(delta: float) -> void:
	if current_node_state:
		current_node_state._on_physics_process(delta)
		current_node_state._on_next_transitions()
		#updates the current state's physics every frame
		#this allows the idle state to constantly check for input and conditions to transition to other states

#transitions to another player state
#this method takes the name of the node that its called on as its argument to transtion to
func transition_to(node_state_name : String) -> void:
	if node_state_name == current_node_state.name.to_lower():
		return
	#return is we are transtioning back to the same state
	
	var new_node_state = node_states.get(node_state_name.to_lower())
	#assigns the refernece to the new node by running get(node_name) on the node_states dictionary
	
	if !new_node_state:
		return
	#returns if there isnt a state to transition to
	
	if current_node_state:
		current_node_state._on_exit()
	#exits the current state
	
	new_node_state._on_enter()
	#starts the next state
	
	current_node_state = new_node_state	
	current_node_state_name = current_node_state.name.to_lower()
	#updates the current state
