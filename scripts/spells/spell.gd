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

const EMPTY = preload("res://scenes/spells/Empty.tres")

## Returns list of all spells
func get_spell_list_paths() -> Array[String] :
	return ["res://scenes/spells/MagicDart/MagicDart.res",
		"res://scenes/spells/BubbleShield/BubbleShield.res",
		"res://scenes/spells/Claymore/Claymore.res"]
