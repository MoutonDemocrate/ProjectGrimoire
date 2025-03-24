extends Node3D
class_name Map
## Class to manage battle maps.

@export var map_name : String = "Unnamed Map"
@export_multiline var map_desc : String = "An Unnamed Map"

@export var spawn_points_1 : Array[Marker3D]
@export var spawn_points_2 : Array[Marker3D]
