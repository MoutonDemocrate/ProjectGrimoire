extends State
class_name StatePhysics

func ready() -> void :
	pass

func left(new_state : State) :
	state_left.emit()

func entered(old_state : State) :
	state_entered.emit()

func state_input(event : InputEvent) :
	pass

func state_process(_delta:float) :
	pass

func state_physics(_delta:float) :
	pass
