extends Resource
class_name Team

@export var color : Color = Color.CYAN
var members : Array[Node] = []

func find_members(from_class : String) -> Array[Node] :
	var lot : Array[Node] = []
	for node in members :
		if node.get_class() == from_class :
			lot.append(node)
	return lot