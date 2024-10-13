extends Control

@onready var tabcont_base : TabContainer = $TabContainer
@onready var tabcont_join_host : TabContainer = $TabContainer/TabContainerJoinHost

@onready var host_panel : PanelContainer = $"TabContainer/TabContainerJoinHost/Host A Room"
@onready var join_panel : VBoxContainer = $"TabContainer/TabContainerJoinHost/Join A Room"
@onready var room_menu : RoomMenu = $TabContainer/RoomMenu

var peer := ENetMultiplayerPeer.new()

var player_span_array : Array[PlayerSpan] = []

func _ready() -> void:
	multiplayer.allow_object_decoding = true
	host_panel.create_room.connect(_on_host_pressed)
	join_panel.join_room.connect(_on_join_pressed)


func _on_host_pressed(room_name:String, password:String, port:int) -> void:
	var room_info := RoomMenu.RoomInfo.new()
	room_info.name = room_name
	room_info.password = password
	room_info.ip = NetworkUtils.get_local_ip()
	room_info.port = port
	print("Creating room with RoomInfo=",room_info._to_string())
	
	peer.create_server(port)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(peer_connected)

	room_menu.room_info = room_info
	room_menu.vbox_room_settings.set_multiplayer_authority(1,true)
	tabcont_base.current_tab = 1
	var player_span : PlayerSpan = PlayerSpan.DEFAULT_SPAN_SCENE.instantiate()
	room_menu.player_list.add_child(player_span)
	player_span_array.append(player_span)
	player_span.set_multiplayer_authority(1,true)
	player_span.host = true
	player_span.deck = Deck.DEFAULT_DECK
	player_span.player_name = "Hostman"
	player_span.player_title = "The Dev"
	print("Server created.")

func _on_join_pressed(ip:String,port:int) -> void :
	print("Connecting to server")
	peer.create_client(ip, port)
	multiplayer.multiplayer_peer = peer
	
	tabcont_base.current_tab = 1

func peer_connected(id : int) -> void :
	print("Peer Connected !")
	var player_span : PlayerSpan = PlayerSpan.DEFAULT_SPAN_SCENE.instantiate()
	room_menu.player_list.add_child(player_span)
	player_span_array.append(player_span)
	player_span.set_multiplayer_authority(id,true)
	player_span.host = false
	player_span.deck = Deck.DEFAULT_DECK
	player_span.player_name = "Player"
	player_span.player_title = "Apprentice"
	await GeneralUtils.wait(0.5)
	sync_spans.rpc(player_span_array)



@rpc("any_peer", "call_local", "reliable")
func sync_spans(span_array:Array) -> Error :
	# TO ALL CLIENTS
	# HERE ARE THE PLAYER SPANS, PLEASE ADD THEM ALL THERE
	print("Hi, I'm client n°",peer.get_unique_id()," and I'm syncing my spans properly :> ",span_array)
	for child in room_menu.player_list.get_children() : child.queue_free() ;
	for span in span_array :
		var span_aux : PlayerSpan = PlayerSpan.DEFAULT_SPAN_SCENE.instantiate()
		room_menu.player_list.add_child(span_aux)
	return OK
