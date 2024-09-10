extends PanelContainer

@export var deck : Deck = Deck.DEFAULT_DECK :
	set(new_deck) :
		deck_name_label.text = new_deck.name
		self.tooltip_text = deck.description
		deck = new_deck

@onready var deck_name_label : Label = $"HBoxContainer/DeckName"

func _ready() -> void:
	deck = deck