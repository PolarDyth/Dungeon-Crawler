extends Node
class_name StateMachine

signal state_finished

@export var initial_state: State
@export var actor: Node

var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.actor = actor
			child.state_machine = self
			child.finished.connect(_on_state_finished)

	# Children _ready before their parent, so entering the initial state now
	# would run before the actor's @onready variables are assigned.
	if initial_state:
		enter_initial_state.call_deferred()

func enter_initial_state():
	initial_state.enter()
	current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float):
	if current_state:
		current_state.physics_update(delta)

func transition_to(new_state_name: String):
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		push_error("State machine does not contain state: ", new_state_name)
		return

	if current_state:
		current_state.exit()

	new_state.enter()
	current_state = new_state

func current_state_name() -> String:
	if current_state:
		return current_state.name.to_lower()
	return ""

func _on_state_finished():
	if current_state:
		current_state.exit()
	current_state = null
	state_finished.emit()
