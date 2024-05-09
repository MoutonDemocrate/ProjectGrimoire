extends RigidBody3D
class_name DestroyFragment

@export var lifetime : float = 1.0
@export var wait_for_ground : bool = true
@export var max_lifetime : float = 10.0
var mesh:MeshInstance3D
var collision:CollisionShape3D

var grounded : bool = false
var slow_down_cowboy := 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if wait_for_ground :
		if slow_down_cowboy > 0 :
			slow_down_cowboy -= delta
			return
		if not grounded and ((linear_velocity.length() + angular_velocity.length()) <= 0.1 or max_lifetime <= 0) :
			grounded = true
		elif grounded :
			lifetime -= delta
		max_lifetime -= delta
	else :
		lifetime -= delta
	if lifetime <= 0 :
		die()

var tween : Tween 
func die():
	tween = create_tween()
	tween.tween_property(mesh,"scale",Vector3.ZERO,1.0)
	await tween.finished
	queue_free()

func init_from_mesh(source_mesh : MeshInstance3D) :
	global_transform = source_mesh.global_transform
	
	mesh = MeshInstance3D.new()
	mesh.transform = Transform3D.IDENTITY
	mesh.mesh = source_mesh.mesh
	add_child(mesh)
	
	collision = CollisionShape3D.new()
	collision.transform = Transform3D.IDENTITY
	collision.shape = source_mesh.mesh.create_convex_shape()
	collision.shape.margin = 0.02
	add_child(collision)
