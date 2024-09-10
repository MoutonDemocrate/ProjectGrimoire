extends Control
class_name UISpellCard

@export var spell : Spell = Spell.EMPTY
@export var acceleration : float = 8

@onready var card_mesh : MeshInstance3D = $MarginContainer/UISpellCard/SubViewport/MeshInstance3D

## Relative mouse position
var relative : Vector2 = Vector2.ZERO

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void :
	set_process(true)

func _on_mouse_exited() -> void:
	set_process(false)
	create_tween().tween_property(card_mesh, "rotation_degrees", Vector3(90,0,0),0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion :
		var mouse_pos : Vector2 = event.position
		mouse_pos -= self.position
		mouse_pos.x /= self.size.x
		mouse_pos.y /= self.size.y
		relative = (mouse_pos - 0.5*Vector2.ONE)*2

func _process(delta: float) -> void:
	card_mesh.rotation_degrees.x = lerpf(card_mesh.rotation_degrees.x, 90 + relative.y*30, acceleration * delta)
	card_mesh.rotation_degrees.y = lerpf(card_mesh.rotation_degrees.y, relative.x*30, acceleration * delta)
