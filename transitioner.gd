extends Node

var player_position: float # Relative position w/r/t where the player exited. Is a float for reasons, you'll see.
var player_facing_direction: Vector2
var player_side: Types.TransitionSide
var player_velocity: Vector2

var game_has_started: bool = false
