@tool
extends Resource
class_name PlayerInfo

@export var host : bool = false :
	set(p_host):
		host = p_host

@export var player_name : String = "Player" :
	set(p_player_name):
		player_name = p_player_name

@export var player_title : String = "Apprentice" :
	set(p_player_title):
		player_title = p_player_title

@export var deck : Deck = Deck.DEFAULT_DECK

func _init(
	b_host:bool=false,
	b_name:String="Player",
	b_title:String="Apprentice",
	b_deck:Deck=Deck.DEFAULT_DECK
	) :
	host = b_host
	player_name = b_name
	player_title = b_title
	deck = b_deck

## Parses PlayerInfo to Dictionnary
func to_dict() -> Dictionary :
	return {
		"player_name" : player_name,
		"host" : host,
		"player_title" : player_title,
		"deck" : deck.to_dict()
	}

## Parses Dictionnary to PlayerInfo
static func from_dict(dict : Dictionary) -> PlayerInfo :
	var info : PlayerInfo = PlayerInfo.new()
	print(dict)
	print(dict["player_name"])
	info.player_name = dict["player_name"] if "player_name" in dict.keys() else "Unnamed Player"
	info.host = dict["host"] if "host" in dict.keys() else false
	info.player_title = dict["player_title"] if "player_title" in dict.keys() else "Apprentice"
	info.deck = Deck.from_dict((dict["deck"] as Dictionary))  if "deck" in dict.keys() else Deck.DEFAULT_DECK
	return info
