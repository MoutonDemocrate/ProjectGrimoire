extends Resource
class_name GameSettings

## Class used to save/load game settings presets.

const DEFAULT_SETTINGS = preload("res://assets/game/DefaultGameSettings.tres")

## Name of the preset, if saved. [br] Cannot be empty.
@export var preset_name : String = "Unnamed Preset"

## Number of rounds in a game. [br] Upgrade phases take place in-between each round. [br]
## [br]
## [color=orange][b]/!\ Warning /!\[/b][/color] : Leaving at 1 will remove upgrade phases.
@export var number_of_rounds : int = 3

## Time for a single round. [br]
## Leave at [code]0.0[/code] for unlimited time (deathround)
@export var round_time : float = 0.0

## Number of upgrades for each player during upgrade phases. [br]
## [br]
## [color=orange][b]/!\ Warning /!\[/b][/color] : must be higher than [code]player_count * [/code][member upgrade_pick_amount]
@export var upgrade_pick_amount : int = 3

## Number of teams in the game. [br]
## If left to [code]0[/code] or [code]1[/code], the game will be a free-for-all,
## and will (behind the scenes) create a team for each player.
@export var number_of_teams : int = 0
