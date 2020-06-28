extends "res://scripts/state.gd"

var InputUtil = preload("res://player/player_input_util.gd").new()
export var speed: float = 250

export(NodePath) var on_stop

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_enter():
	owner.get_node("AnimationPlayer").play("walk")

func process_state(delta):
	if abs(InputUtil.get_direction().length()) == 0:
		self.change_state(on_stop)

func process_physics_state(delta):
	InputUtil.look_at_mouse(owner)
	
	var direction: Vector2 = InputUtil.get_direction()
	if direction.length() != 0:
		owner.move_and_slide(direction * speed, Vector2(0, 0), false, 4, 0.785398, false)
