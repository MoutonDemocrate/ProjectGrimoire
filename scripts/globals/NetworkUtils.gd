extends Node

func _ready() -> void:
	print("Hey, IP is : ", get_local_ip())

func get_local_ip() -> String :
	for ip in IP.get_local_addresses() :
		if ip.begins_with("10.") or ip.begins_with("172.16.") or ip.begins_with("192.168."):
			return ip
	return "Error!"
