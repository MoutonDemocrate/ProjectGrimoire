@tool
extends AspectRatioContainer
class_name SpellCard

@onready var texture_rect : TextureRect = $TextureRect
@onready var panel : Panel = $Panel
@onready var label : Label = $Label

@export var spell : Spell = load("res://scenes/spells/Empty.tres") :
	set(new_spell) :
		spell = new_spell
		if is_node_ready() :
			texture_rect.texture = spell.icon
			label.text = str(spell.cost) if spell.cost > 0 else ""
	get :
		return spell

@export var color : Color = Color.WHITE :
	set(new_color) :
		color = new_color
		if is_node_ready() :
			panel.self_modulate = color
	get :
		return color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
