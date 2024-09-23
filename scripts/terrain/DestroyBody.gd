extends StaticBody3D
class_name DestroyBody

@export_category("Stats")
@export var max_health : float = 1.5

@export_category("Appearance")
@export var break_material : BaseMaterial3D
@export var random_rotate : bool = false
@export var frac_lifetime : float = 1
@export var frac_wait_for_ground : bool = false
@export_flags_3d_physics var fragment_collision_layer : int = 1
@export_flags_3d_physics var fragment_collision_mask : int = 1
@export var mass : float = 5
@export var recover : bool = true
@export var recover_time : float = true

@onready var collision_shape : CollisionShape3D = $CollisionShape3D
@onready var mesh : MeshInstance3D = $MeshInstance3D
@onready var frac : Node3D = self.get_child(0)

var frac_list : Array[MeshInstance3D]
var frag_list : Array[DestroyFragment]

@onready var health : float = max_health

# Called when the node enters the scene tree for the first time.
func _ready():
	frac.hide()
	for child in frac.get_children() :
		frac_list.append(child)

func damage(amount : float, from : Node3D) :
	health -= amount
	if health < 0 :
		destroy(from)
		await get_tree().create_timer(1.0).timeout
		recreate()


func destroy(destroyer : Node3D):
	mesh.hide()
	frag_list = []
	self.process_mode = Node.PROCESS_MODE_DISABLED
	for child in frac_list :
		if child is MeshInstance3D :
			var frag:DestroyFragment = DestroyFragment.new()
			frag.init_from_mesh(child)
			if break_material :
				frag.mesh.material_override = break_material
			frag.collision_layer = fragment_collision_layer
			frag.collision_mask = fragment_collision_mask
			self.get_parent().add_child(frag)
			frag_list.append(frag)
			frag.show()
			
	var destroy_power : float
	if "destroy_power" in destroyer.get_property_list() :
		destroy_power = destroyer.destroy_power
	elif "damage" in destroyer.get_property_list() :
		destroy_power = destroyer.damage
	else :
		destroy_power = 1
	
	var max_distance : float = 0.0
	for frag in frag_list :
		max_distance = maxf(max_distance, (frag.position - destroyer.position).length())
	
	var distance_norm : float = 0.0
	for frag in frag_list :
		distance_norm = (frag.position - destroyer.position).length()/max_distance - 1.0
		frag.linear_velocity = (frag.position - destroyer.position).normalized() * destroy_power * exp((distance_norm**2)/0.2) / mass

func _set_mesh_mat_rate_0(percent : float):
	mesh.material_override.albedo_texture.color_ramp.offsets[0] = percent
	
func _set_mesh_mat_rate_1(percent : float):
	mesh.material_override.albedo_texture.color_ramp.offsets[1] = percent
	
var mat : StandardMaterial3D = load("res://assets/models/terrain/materials/reappear.tres")
var tween : Tween
func recreate() -> void:
	print("RECREATING")
	#mesh.show()
	await get_tree().create_timer(5.0).timeout
	
	#mesh.set_material_override(load("res://assets/models/terrain/materials/reappear.tres"))
	#await get_tree().create_timer(1.0).timeout
	#tween = create_tween()
	#tween.tween_property(mesh,"material_override/albedo_texture/color_ramp/offsets",[0.0,1.0],1.2)
	#await tween.finished
	
	mesh.show()
	mesh.material_override = null
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	health = max_health
