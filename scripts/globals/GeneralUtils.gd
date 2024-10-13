extends Node

func wait(duration : float) -> void :
	await get_tree().create_timer(duration).timeout
