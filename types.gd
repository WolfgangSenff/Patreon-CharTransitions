class_name Types
extends RefCounted

enum TransitionSide { Up, Right, Down, Left }

static var TransitionSideOpposites = { TransitionSide.Up: TransitionSide.Down, TransitionSide.Down: TransitionSide.Up, TransitionSide.Right: TransitionSide.Left, TransitionSide.Left: TransitionSide.Right }
