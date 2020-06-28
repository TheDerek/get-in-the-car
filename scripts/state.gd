extends Node

signal change_state(new_state_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func process_state(delta):
	pass # Not implemented
	

func process_physics_state(delta):
	pass # Not implemented

func on_enter():
	pass # Not implemented

func on_exit():
	pass # Not implemented


func change_state(new_state_path: NodePath):
	emit_signal("change_state", get_parent().get_path_to(get_node(new_state_path)))
