extends CharacterBody3D
class_name Player

@export_group("Characteristics")
@export var color : Color = Color.REBECCA_PURPLE

@export_group("Resources")
## Charge : used to hover, and for other movement options.
@export_range(0,100,0.001,"or_greater") var charge : float = 1.0
## Mana : used to cast spells.
@export_range(0,100,1,"or_greater") var mana : int = 5
## Player health : if it reaches 0, the player dies.
@export_range(0,100,1,"or_greater") var health : int = 10

@export_group("Physics Constants")
@export var speed : float = 10
@export var jump_height : float = 10
@export var acceleration : float = 10
@export var vertical_acceleration : float = 0.3
@export var falling_velocity : float = -53.0
@export var gliding_velocity : float = -10
@export var gliding_acceleration : float = 10  
@export var charge_slowdown : float = 10

@export_group("Cosmetic Constants")
@export var angular_acceleration : float = 10
@export var locked_to_target : bool = false

## SIGNALS
signal mana_changed(before:int, after:int)
signal health_changed(before:int, after:int)

@onready var player_body : Node3D = $wizard
@onready var spring_arm_3d : SpringArm3D = $SpringArm3D
@onready var machine : PhysicsMachine = $PlayerMachine
@onready var spell_manager : SpellManager = $SpellManager
@onready var ui_layer : UILayer = $UILayer
@onready var mana_timer : Timer = $ManaTimer



var direction : Vector3 = Vector3.ZERO
var flat_direction : Vector2 = Vector2.ZERO

var spring_arm_rot : float

var target : Node3D

func _process(delta: float) -> void:
	machine.machine_process(delta)

func _physics_process(_delta):
	machine.machine_physics(_delta)

func _unhandled_input(event):
	machine.machine_input(event)

func increment_mana(amount:=1):
	mana += amount
	mana_changed.emit(mana-amount, mana)
	print("Mana is now : ", mana)

func damage(damage : Damage) -> void :
	# for status in status_manager :
		pass
