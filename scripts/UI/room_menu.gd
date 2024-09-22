extends PanelContainer
class_name RoomMenu

@onready var room_name_edit : LineEdit = $HBoxContainer/VBoxRoomSettings/PanelContainer/VBoxContainer/ScrollContainer/MarginContainer/VBoxInfo/HBoxInfoName/LineEdit

@export var room_info : RoomInfo = RoomInfo.new() :
	set(new_info) :
		room_name_edit.text = new_info.name
		room_info = new_info

@export var game_settings : GameSettings = GameSettings.DEFAULT_SETTINGS :
	set(new_settings) :
		game_settings = new_settings

@onready var vbox_room_settings : VBoxContainer = $HBoxContainer/VBoxRoomSettings

class RoomInfo extends Resource :
	var name : String = "Arcane Room"
	var ip : String = "127.0.0.1"
	var port : int = 8999
	var password : String = ""
