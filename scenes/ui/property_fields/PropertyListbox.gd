@tool
extends VBoxContainer
class_name PropertyListbox
## A Control to display all properties from a give ressource or node.

@export var resource : Resource :
	set(new) :
		resource = new
		update_property_fields()

func update_property_fields() -> void:
	for child in get_children() :
		child.free()
	for property in resource.get_property_list() :
		print("Found property ", property["name"])
		if property["usage"] & PROPERTY_USAGE_EDITOR && property["usage"] & PROPERTY_USAGE_STORAGE and property["name"] not in ["resource_local_to_scene","resource_name","script","metadata/_custom_type_script"] :
			print("It's exported probably")
			var field : PropertyField = PropertyFieldLabel.SCENE.instantiate()
			self.add_child(field)
			field.subject = resource
			field.property = property["name"]
			var value = resource[property["name"]]
			var stringval := ""
			if value is Object :
				if value.has_method("to_string"):
					stringval = value.to_string()
				elif value.has_method("_to_string"):
					stringval = value._to_string()
			else :
				stringval = str(value)
			if value in field.get_property_list().map(func (dict:Dictionary) : return dict["name"]) :
				field.value = stringval
