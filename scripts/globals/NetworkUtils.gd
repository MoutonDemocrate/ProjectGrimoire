extends Node

func _ready() -> void:
	print("Hey, adresses are {0}, IP is {1}".format([IP.get_local_addresses(), get_local_ip()]))

func get_local_ip() -> String :
	var adress_list : PackedStringArray = IP.get_local_addresses()
	if not adress_list :
		return "Error!"
	else :
		for ip : String in adress_list :
			if ip.begins_with("10.") or ip.begins_with("172.16.") or ip.begins_with("192.168."):
				return ip
		for ip : String in adress_list :
			if len(ip.split(".")) and "0" not in ip.split("."):
				return ip
		for ip : String in adress_list :
			if len(ip.split(".")):
				return ip
	return "Error!"
