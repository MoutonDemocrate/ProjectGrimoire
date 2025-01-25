extends Node
class_name GameManager
## Manages the game, including rounds and upgrade phases.


## Game settings.
@export var game_settings : GameSettings = GameSettings.DEFAULT_SETTINGS

enum GameState {
	LOBBY,
	PRE_ROUND,
	ROUND,
	PRE_UPGRADE,
	UPGRADE,
	SCORE
}

var teams : Array[Team]
var round_counter : int = 0
var game_state : GameState = GameState.LOBBY
