extends Resource
class_name Spell

@export var name : String
@export var id : String
@export var icon : Texture2D
@export var cost : int
@export var damage : int
@export var duration : float
@export_multiline var description : String
@export var state_scene : PackedScene

const EMPTY = preload("res://scenes/spells/empty.tres")

## Returns list of all spells
func get_spell_list_paths() -> Array[String] :
	return [
		"res://scenes/spells/dart/MagicDart.res",
		"res://scenes/spells/bubble_shield/BubbleShield.res",
		"res://scenes/spells/claymore/Claymore.res"
	]

## Finds spell from ID
static func from_id(id : String) -> Spell :
	match id :
		"dart" : return load("res://scenes/spells/dart/MagicDart.res")
		"bubble_shield" : return load("res://scenes/spells/bubble_shield/BubbleShield.res")
		"claymore" : return load("res://scenes/spells/claymore/Claymore.res")
		_ : return Spell.EMPTY
