extends "res://scripts/state.gd"

var InputUtil = preload("res://player/player_input_util.gd").new()

export(NodePath) var on_move

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_enter():
	get_node("../../AnimationPlayer").play("idle")

func process_state(delta):
	InputUtil.look_at_mouse(owner)
	
	if abs(InputUtil.get_direction().length()) > 0:
		self.change_state(on_move)
