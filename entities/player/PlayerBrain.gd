extends Node

# Player-specific decision logic: reads input and tells the StateMachine
# where to go. The machine itself stays game-agnostic, so an enemy could
# reuse it with its own brain.

@onready var state_machine: StateMachine = get_node("../StateMachine")

func _ready():
	state_machine.state_finished.connect(select_state)

func _physics_process(_delta: float):
	select_state()

func select_state():
	# Interrupt states (attack, later dash/hurt) keep control until they
	# report finished; the brain stands down while one is active.
	var state := state_machine.current_state
	if state and state.is_interrupt:
		return

	if Input.is_action_just_pressed("shoot"):
		state_machine.transition_to("attack")
		return

	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var target := "idle"
	if input_dir != Vector2.ZERO:
		target = "run" if Input.is_action_pressed("sprint") else "walk"

	if target != state_machine.current_state_name():
		state_machine.transition_to(target)
