extends Area3D

@export_category("Balance")
@export var damage : float = 3
@export var destroy_power : float = damage

@export_group("Constants")
@export var swing_speed : float = 5
@export var swing_acceleration : float = 5

var caster : Player
var target : Node3D

@onready var mesh : MeshInstance3D = $MeshInstance3D
@onready var collision_shape : CollisionShape3D = $CollisionShape3D

var swing : bool = false

func _ready() -> void :
	pass
