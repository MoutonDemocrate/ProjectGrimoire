extends PanelContainer
class_name RoomMenu

@export var room_info : RoomInfo = RoomInfo.new() :
	set(new_info) :
		room_info = new_info

@export var game_settings : GameSettings = GameSettings.DEFAULT_SETTINGS :
	set(new_settings) :
		game_settings = new_settings

class RoomInfo extends Resource :
	var name : String = "Arcane Room"
	var ip : String = "127.0.0.1"
	var port : int = 8999
	var password : String = ""
	