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

@export var host : bool = false :
	set(p_host):
		if not Engine.is_editor_hint() :
			await ready
		host = p_host
		if host :
			label_room_title.add_theme_color_override("font_color", Color.RED)
		else :
			label_room_title.add_theme_color_override("font_color", Color.GREEN)
		if self.is_node_ready() :
			label_room_title.text = "Host" if p_host else "Guest"

@export var player_name : String = "Player" :
	set(p_player_name):
		player_name = p_player_name
		if self.is_node_ready() :
			label_name.text = p_player_name

@export var player_title : String = "Apprentice" :
	set(p_player_title):
		player_title = p_player_title
		if self.is_node_ready() :
			label_player_title.text = p_player_title

@export var deck : Deck = Deck.DEFAULT_DECK
