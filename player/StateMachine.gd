extends Node

var current_state: NodePath

export(NodePath) var starting_state

func get_current_state():
	return get_node(self.current_state)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Starting in state: " + starting_state)
	self.current_state = starting_state
	
	for node in get_children():
		node.connect("change_state", self, "change_state")
	
	self.get_current_state().on_enter()


func change_state(new_state_path: NodePath):
	print("Changing state: " + current_state + " -> " + new_state_path)
	self.get_current_state().on_exit()
	self.current_state = new_state_path
	self.get_current_state().on_enter()
	

func _process(delta):
	get_current_state().process_state(delta)

func _physics_process(delta):
	get_current_state().process_physics_state(delta)
