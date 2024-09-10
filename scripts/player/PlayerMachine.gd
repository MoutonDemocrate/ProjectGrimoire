extends PhysicsMachine

@onready var player : Player = $".."

@onready var timer : Timer = Timer.new()

func _ready() -> void :
	refetch_states()
	current_state = states[0]
	timer.one_shot = true
	timer.wait_time = 0.5
	add_child(timer)

func machine_physics(_delta: float) -> void:
	player.spring_arm_rot = player.spring_arm_3d.rotation.y
	player.player_body.rotation.y = lerp_angle(player.player_body.rotation.y, player.spring_arm_rot + PI/2 ,_delta * player.angular_acceleration)
	current_state.state_physics(_delta)

func machine_input(event : InputEvent) -> void:

	if event.is_action_pressed("cast1") :
		timer.start()
	elif event.is_action_released("cast1") :
		if timer.is_stopped() :
			player.spell_manager.cast(4)
		else:
			player.spell_manager.cast(1)

	elif event.is_action_pressed("cast2") :
		timer.start()
	elif event.is_action_released("cast2") :
		if timer.is_stopped() :
			player.spell_manager.cast(5)
		else:
			player.spell_manager.cast(2)

	elif event.is_action_pressed("cast3") :
		timer.start()
	elif event.is_action_released("cast3") :
		if timer.is_stopped() :
			player.spell_manager.cast(6)
		else:
			player.spell_manager.cast(3)

	current_state.state_input(event)
