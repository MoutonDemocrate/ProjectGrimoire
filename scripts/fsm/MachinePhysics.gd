extends Machine
class_name PhysicsMachine

func machine_input(event : InputEvent) :
	current_state.state_input()

func machine_process(delta) :
	current_state.state_process(delta)

func machine_physics(delta) :
	current_state.state_physics(delta)
