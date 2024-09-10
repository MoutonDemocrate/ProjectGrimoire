extends Control

@onready var tabcont_base : TabContainer = $TabContainer
@onready var tabcont_join_host : TabContainer = $TabContainer/TabContainerJoinHost

@onready var host_panel : PanelContainer = $"TabContainer/TabContainerJoinHost/Host A Room"
@onready var join_panel : PanelContainer = $"TabContainer/TabContainerJoinHost/Join A Room"
@onready var room_menu : RoomMenu = $TabContainer/RoomMenu


func _ready() -> void:
	host_panel.create_room.connect(_on_host_pressed)
	join_panel.join_room.connect(_on_join_pressed)

func _on_host_pressed(room_name:String, password:String, port:int) -> void:
	var room_info := RoomMenu.RoomInfo.new()
	room_info.name = room_name
	room_info.password = password
	room_info.ip = NetworkUtils.get_local_ip()
	room_info.port = port

	room_menu.room_info = room_info
	tabcont_base.current_tab = 1

func _on_join_pressed(ip:String,port:int) -> void :
	pass