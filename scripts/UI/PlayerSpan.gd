@tool
class_name PlayerSpan
extends HBoxContainer

const DEFAULT_SPAN_SCENE : PackedScene = preload("res://scenes/ui/PlayerSpan.tscn")

@onready var label_room_title : Label = $LabelRoomTitle
@onready var label_name : Label = $LabelName
@onready var label_player_title : Label = $LabelPlayerTitle

func _enter_tree() -> void:
	print("PlayerSpan entered tree !")

func _ready() -> void:
	print("PlayerSpan is ready !")

@export var player_info : PlayerInfo = PlayerInfo.DEFAULT :
	set(new) :
		if not Engine.is_editor_hint() :
			await ready
		if self.is_node_ready() :
			if new.host :
				label_room_title.add_theme_color_override("font_color", Color.RED)
			else :
				label_room_title.add_theme_color_override("font_color", Color.GREEN)
			label_room_title.text = "Host" if new.host else "Guest"
			label_name.text = new.player_name
			label_player_title.text = new.player_title
		player_info = new
