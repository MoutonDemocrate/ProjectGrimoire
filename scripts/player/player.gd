extends CharacterBody3D
class_name Player

@export_group("Characteristics")
@export var color : Color = Color.REBECCA_PURPLE

@export_group("Resources")
@export_range(0,1,0.001,"or_greater") var charge : float = 1.0
@export_range(0,3,0.001,"or_greater") var mana : float = 100.0
@export var spells : Array[Spell] = [load("res://scenes/spells/MagicDart/MagicDart.tres")]

@export_group("Physics Constants")
@export var speed : float = 10
@export var jump_height : float = 10
@export var acceleration : float = 10
@export var vertical_acceleration : float = 0.3
@export var falling_velocity : float = -53.0
@export var gliding_velocity : float = -10
@export var gliding_acceleration : float = 10  



@onready var machine : StateMachine = $PlayerMachine

var direction : Vector3 = Vector3.ZERO
var flat_direction : Vector2 = Vector2.ZERO

func remove_spell_in_slot(slot : int) :
	if len(spells) >= slot - 1 :
		spells.pop_at(slot-1)

func _physics_process(_delta):
	machine.physics(_delta)

func _unhandled_input(event):
	machine.input(event)
