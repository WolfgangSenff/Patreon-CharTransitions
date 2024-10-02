extends Node2D

# Never, ever detach your player and re-attach it in the new level. Have one already in the new level, and have the transitioner store the relevant information about the player from one level to the next.
# One reason for this is that you should be able to play a level on its own without having to add or remove a player node. Another is that managing the scene tree in this way is ugly and awful. See most of
# my other Patreon posts for why I hate to remove nodes and re-parent them anywhere.

# Also, note that because your player is directly in the level scene already, you can count on being able to place it no matter how long it takes your transition to complete. Godot inherently puts a frame
# between scene transitions due to reasons of tree management, and a lot of folks don't realize that and end up with an absolute mess trying to place the player in the new scene before the new scene actually
# exists in the scene tree. Why bother!? Just rely on _ready, and have the player in the scene automatically.

const PlayerHeight = 44 # Only doing this to account for the size of the collision shape
const PlayerWidth = 28

func _ready() -> void:
	if not Transitioner.game_has_started:
		Transitioner.game_has_started = true
		return # Exit early, we're on the first level, so leave player exactly where it is placed; works for any scene
	
	%Player.facing_direction = Transitioner.player_facing_direction
	%Player.velocity = Transitioner.player_velocity
	
	var all_transitions = get_tree().get_nodes_in_group("Transition") # Using groups purely so the TransitionAreas can go into any spot in the tree hierarchy. Also, I didn't save my TransitionArea as a scene so that
																	 # I wouldn't have to Edit Children on all my TransitionAreas to define the size of their collision shapes. But it's a thing that should happen for
																	 # multiple exits. Note also this only handles a single exit per side, but can switch to using resources to define which exit corresponds to which entry.
	
	var new_transition = null
	var new_side = Types.TransitionSideOpposites[Transitioner.player_side]
	for transition in all_transitions:
		if transition.ExitSide == new_side:
			new_transition = transition
			break
	
	assert(new_transition != null, "Missing transition for %s in current scene" % new_side)
	
	if new_side in [Types.TransitionSide.Left, Types.TransitionSide.Right]:
		%Player.position = Vector2(new_transition.EntryMarker.position.x, Transitioner.player_position + new_transition.EntryMarker.position.y)
	else:
		%Player.position = Vector2(Transitioner.player_position + new_transition.EntryMarker.position.x, new_transition.EntryMarker.position.y)
	
	# Above takes into account whether or not you're exiting on top or bottom of screen, or left or right; note we care about different values when positioning the player in the new scene, and this is true for any game type, not just side-scrollers
