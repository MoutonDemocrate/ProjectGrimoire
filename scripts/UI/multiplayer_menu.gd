extends Control

@onready var tabcont_base : TabContainer = $TabContainer
@onready var tabcont_join_host : TabContainer = $TabContainer/TabContainerJoinHost

@onready var host_panel : PanelContainer = $"TabContainer/TabContainerJoinHost/Host A Room"
@onready var join_panel : VBoxContainer = $"TabContainer/TabContainerJoinHost/Join A Room"
@onready var room_menu : RoomMenu = $TabContainer/RoomMenu

const player_span_scene : PackedScene = preload("res://scenes/ui/PlayerSpan.tscn")

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
	room_menu.vbox_room_settings.set_multiplayer_authority(1,true)
	tabcont_base.current_tab = 1
	print("Creating room with RoomInfo=",room_info)
	var player_span : PlayerSpan = player_span_scene.instantiate()
	room_menu.add_player_span(player_span)
	player_span.host = true
	player_span.deck = Deck.DEFAULT_DECK
	player_span.player_name = "Hostman"
	player_span.player_title = "The Dev"
	print("Tout va bieng???")

func _on_join_pressed(ip:String,port:int) -> void :
	pass
