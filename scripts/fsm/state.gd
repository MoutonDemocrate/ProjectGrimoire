extends Node
class_name State

@onready var machine : StateMachine = get_parent()

signal state_left()
signal state_entered()

func ready() -> void :
	pass

func left(new_state : State) :
	state_left.emit()

func entered(old_state : State) :
	state_entered.emit()
