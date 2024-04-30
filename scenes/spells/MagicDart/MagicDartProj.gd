extends Area3D

@export var caster : Player
@export var target : Node3D

@export_group("Constants")
@export var angle_per_second : float = 5.0
@export var angle_var_per_second : float = 2.0
@export var speed : float = 20.0
@export var final_speed : float = 10.0
@export var speed_decrease_duration : float = 1

@onready var mesh : MeshInstance3D = $MeshInstance3D
@onready var collision_shape : CollisionShape3D = $CollisionShape3D

var direction : Vector3
var last_pos : Vector3
var technical_direction : Vector3

var init_angle : float = angle_per_second

var initialised : bool = false

func _ready():
	$GPUParticles3DStart.emitting = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if initialised :
		direction = lerp(direction.normalized(), (target.position - position).normalized(), clampf(angle_per_second*delta/direction.angle_to((target.position - position)),0.0,1.0))
		last_pos = position
		position += direction*speed*delta
		
		angle_per_second = clampf(angle_per_second + angle_var_per_second*delta,angle_per_second,init_angle*4.0)
		speed = clampf(speed - speed_decrease_duration*delta,final_speed,speed)
		
		technical_direction = position - last_pos
		look_at((position + technical_direction))

func _on_body_entered(body):
	if body == caster :
		print("Body hit ! It's my wizard :)")
	else :
		print("Body hit ! It's ",body)
		mesh.hide()
		initialised = false
		$GPUParticles3DEnd.emitting = true
		await $GPUParticles3DEnd.finished
		queue_free()
