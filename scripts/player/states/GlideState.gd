extends State

@onready var player : Player = $"../.."

func physics(_delta):
	player.flat_direction = Input.get_vector("left","right","forward","backward").rotated(-player.spring_arm_rot).normalized()
	player.velocity.x = lerpf(player.velocity.x, player.flat_direction.x * player.speed/2, player.acceleration*_delta/4)
	player.velocity.z = lerpf(player.velocity.z, player.flat_direction.y * player.speed/2, player.acceleration*_delta/4)
	player.velocity.y = lerpf(player.velocity.y, player.gliding_velocity, player.gliding_acceleration*_delta)
	player.move_and_slide()

	if not Input.is_action_pressed("jump"):
		machine.change_state_from_name("Air")

	if player.is_on_floor() :
		machine.change_state_from_name("Moving")

func input(event):
	pass
