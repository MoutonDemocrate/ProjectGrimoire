extends Node
class_name SpellManager

@onready var player : Player = $".."

var spells : Array[Spell] = [SPELL_EMPTY,SPELL_EMPTY,SPELL_EMPTY,SPELL_EMPTY,SPELL_EMPTY,SPELL_EMPTY]

const SPELL_EMPTY : Spell = preload("res://scenes/spells/Empty.tres")

func _ready():
	await player.ready
	add_spell(load("res://scenes/spells/MagicDart/MagicDart.tres"))
	add_spell(load("res://scenes/spells/MagicDart/MagicDart.tres"))
	add_spell(load("res://scenes/spells/MagicDart/MagicDart.tres"))
	add_spell(load("res://scenes/spells/MagicDart/MagicDart.tres"))
	add_spell(load("res://scenes/spells/MagicDart/MagicDart.tres"))
	add_spell(load("res://scenes/spells/MagicDart/MagicDart.tres"))
	refresh_spells()

func refresh_spells() -> void :
	print("REFRESH BEGIN ---------")
	for i in range(1,6) :
		print(player.ui_layer.spell_container.get_child(i-1).spell.id)
		if player.ui_layer.spell_container.get_child(i-1).spell.id == "empty"  :
			player.ui_layer.spell_container.get_child(i-1).spell = player.ui_layer.spell_container.get_child(i).spell
			player.ui_layer.spell_container.get_child(i).spell = SPELL_EMPTY
	for i in range(0,6) :
		spells[i] = player.ui_layer.spell_container.get_child(i).spell

## Adds slot
func add_spell(spell : Spell, slot : int = -1) -> void :
	if (slot == -1) :
		var i = 0
		while player.ui_layer.spell_container.get_child(i).spell.id != "empty" :
			i += 1
		player.ui_layer.spell_container.get_child(i).spell = spell
		refresh_spells()
	else:
		push_error("Adding a spell in a specific slot doesn't work yet, sorry.")
		spells[slot-1] = spell
		player.ui_layer.spell_container.get_child(slot-1).spell = spell

func remove_spell_in_slot(slot : int) :
	if len(spells) >= slot - 1 :
		print("SPELL REMOVED ? SLOT = ",slot)
		player.ui_layer.spell_container.get_child(slot-1).spell = SPELL_EMPTY
		refresh_spells()
	else :
		print("len(spells) = ",len(spells))
	
func cast(slot : int) :
	if len(spells) >= 1 and spells[slot-1].id !="empty" :
		var state : State = player.machine.add_state(spells[slot - 1].state_scene.instantiate())
		state.player = player
		state.cast_slot = slot
		player.machine.change_state(state)
