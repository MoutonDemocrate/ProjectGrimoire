@tool
extends PropertyField
class_name PropertyFieldLabel
## Property field for displaying any variable.

const SCENE : PackedScene = preload("res://scenes/ui/property_fields/PropertyFieldLabel.tscn")

@onready var property_label : Label = $PropertyLabel
@onready var value_label : Label = $ScrollContainer/ValueLabel

@export var property_name : String = "" :
	set(new) : 
		property_name = new
		if not self.is_node_ready() :
			await self.ready
		property_label.text = new
		
@export var value : String = "" :
	set(new) : 
		value = new
		if not self.is_node_ready() :
			await self.ready
		value_label.text = new
