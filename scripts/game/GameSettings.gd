extends Resource
class_name GameSettings

const DEFAULT_SETTINGS = preload("res://assets/game/DefaultGameSettings.tres")

@export var preset_name : String = "Default"
var teams : Array[Team] = [Team.new(), Team.new()]