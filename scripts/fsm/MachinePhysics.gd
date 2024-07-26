extends Machine
class_name MachinePhysics

func _ready() -> void :
	refetch_states()
	current_state = states[0]

func refetch_states() -> void :
	states = []
	for child in get_children() :
		if child is State and not child.is_queued_for_deletion():
			states.append(child)
	print("Refetched states : ",states)

# Changes the current state, returns old state
func change_state(new_state : State) -> State :
	var old_state : State = current_state
	current_state = new_state
	print("State changed from ",old_state.name ," to ",new_state.name)
	old_state.left(new_state)
	state_changed.emit(old_state, new_state)
	new_state.entered(old_state)
	return current_state

# Changes the current state from state namestring, returns old state
func change_state_from_name(new_state_name : String) -> State :
	var that_one_state : State
	for state in states :
		if state.name == new_state_name :
			that_one_state = state
	return change_state(that_one_state)

# Changes the current state from state index, returns old state
func change_state_from_index(new_state_index : int) -> State :
	return change_state(states[new_state_index % len(states)])

func add_state(new_state : State) -> State :
	self.add_child(new_state)
	refetch_states()
	return new_state

func delete_state(state : State):
	state.queue_free()
	refetch_states()

func machine_input(event : InputEvent) :
	current_state.state_input()

func machine_process(delta) :
	current_state.state_process(delta)

func machine_physics(delta) :
	current_state.state_physics(delta)
