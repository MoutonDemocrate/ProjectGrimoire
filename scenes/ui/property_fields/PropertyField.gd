extends HBoxContainer
class_name PropertyField
## Abstract class for property fields. [br]
## Property fields have a selected property and will update automatically when the property is modified.

var subject : Object :
	set(new) :
		subject = new
		if "subject_name" in self :
			self.subject_name = String(subject.name)
			
var property : String :
	set(new) :
		property = new
		if "property_name" in self :
			self.property_name = String(new)
