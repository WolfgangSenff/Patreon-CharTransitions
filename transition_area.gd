extends Area2D

@export var ExitSide: Types.TransitionSide
@export var NextScene: String # Note: This is just the name of the scene; code assumes scene will be found in a specific place
@export var EntryMarker: Marker2D

func _on_body_entered(body: Node2D) -> void:
	Transitioner.player_position = body.position.y - EntryMarker.position.y if ExitSide in [Types.TransitionSide.Left, Types.TransitionSide.Right] else body.position.x - EntryMarker.position.x # Get the player's position relative to the area for later use
	Transitioner.player_facing_direction = body.facing_direction # Ensure the player is facing the right way when entering the new screen
	Transitioner.player_side = ExitSide
	Transitioner.player_velocity = body.velocity

	if not NextScene.is_empty():
		var next = "res://%s.tscn" % NextScene # Normally I'd put these all into a folder, but for demonstration purposes, I have not.
		get_tree().call_deferred("change_scene_to_file", next)
