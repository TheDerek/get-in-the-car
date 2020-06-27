extends "res://scripts/state.gd"

var InputUtil = preload("res://player/player_input_util.gd").new()

export(NodePath) var on_stop

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_enter():
	print("Entering the walking state!")

func process_state(delta):
	if abs(InputUtil.get_direction().length()) == 0:
		self.change_state(on_stop)
