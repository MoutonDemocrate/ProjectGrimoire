extends PanelContainer
class_name RoomMenu

@onready var room_name_label : Label = $HBoxContainer/VBoxRoomSettings/PanelContainer/VBoxContainer/ScrollContainer/MarginContainer/VBoxInfo/HBoxInfoName/ScrollContainer/Label2
@onready var password_label : Label = $HBoxContainer/VBoxRoomSettings/PanelContainer/VBoxContainer/ScrollContainer/MarginContainer/VBoxInfo/HBoxInfoPassword/ScrollContainer/Label2
@onready var ip_label : Label = $HBoxContainer/VBoxRoomSettings/PanelContainer/VBoxContainer/ScrollContainer/MarginContainer/VBoxInfo/HBoxInfoIP/ScrollContainer/Label2
@onready var port_label : Label = $HBoxContainer/VBoxRoomSettings/PanelContainer/VBoxContainer/ScrollContainer/MarginContainer/VBoxInfo/HBoxInfoPort/ScrollContainer/Label2

@onready var player_list : VBoxContainer = $HBoxContainer/VBoxContainer/PanelContainerPlayerList/VBoxPlayerList


@export var room_info : RoomInfo = RoomInfo.new() :
	set(new_info) :
		print(new_info.to_string())
		room_name_label.text = new_info.name if new_info.name else room_info.name
		password_label.text = "*".repeat(room_info.password.length()) if room_info.password else "None"
		ip_label.text = new_info.ip
		port_label.text = str(new_info.port)
		room_info = new_info

@export var game_settings : GameSettings = GameSettings.DEFAULT_SETTINGS :
	set(new_settings) :
		game_settings = new_settings

@onready var vbox_room_settings : VBoxContainer = $HBoxContainer/VBoxRoomSettings

func _ready() -> void:
	password_label.get_parent_control().mouse_entered.connect(func(): password_label.text = room_info.password if room_info.password else "None")
	password_label.get_parent_control().mouse_exited.connect(func(): password_label.text = "*".repeat(room_info.password.length()) if room_info.password else "None")
	ip_label.gui_input.connect(
		func(event:InputEvent): 
			if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
				DisplayServer.clipboard_set(ip_label.text)
				ip_label.tooltip_text = "Adress copied !"
				await GeneralUtils.wait(3)
				ip_label.tooltip_text = "Click to copy"
	)
#func add_player_span(player_span : PlayerSpan) -> void :
	#player_list.add_child(player_span)

class RoomInfo extends Resource :
	var name : String = "Arcane Room"
	var ip : String = "127.0.0.1"
	var port : int = 8999
	var password : String = ""
	
	func _init(
		n:= "Arcane Room",
		i:= "127.0.0.1",
		p:= 8999,
		pa:= ""
		) -> void:
		name = n
		ip = i
		port = p
		password = pa
	
	func _to_string() -> String:
		return "({name} at {ip}, {port}, #{psw})".format({
				"name" : name,
				"ip" : ip,
				"port" : port,
				"psw" : password
			})
	
	func to_dict() -> Dictionary :
		return {
			"name": self.name,
			"ip": self.ip,
			"port": self.port,
			"password": self.password,
		}
	
	static func from_dict(dict:Dictionary) -> RoomInfo :
		return RoomInfo.new(
			dict["name"],
			dict["ip"],
			dict["port"],
			dict["password"]
		)
