extends CharacterBody3D
class_name Player

@export_group("Characteristics")
@export var color : Color = Color.REBECCA_PURPLE

@export_group("Resources")
@export_range(0,1,0.001,"or_greater") var charge : float = 1.0
@export_range(0,3,0.001,"or_greater") var mana : float = 100.0

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

@onready var player_body : Node3D = $wizard
@onready var spring_arm_3d : SpringArm3D = $SpringArm3D
@onready var machine : PhysicsMachine = $PlayerMachine
@onready var spell_manager : SpellManager = $SpellManager
@onready var ui_layer : UILayer = $UILayer



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
