extends KinematicBody2D


export var speed: float = 200

var nearby_vehicle = null;

func _process(delta):
	if Input.is_action_just_pressed("enter_vehicle"):
		print(nearby_vehicle)
		if (nearby_vehicle):
			print("Entering vehicle")
			self.nearby_vehicle.add_driver(self)


func _physics_process(delta):
	pass

func add_nearby_vehicle(vehicle: RigidBody2D):
	self.nearby_vehicle = vehicle

func remove_nearby_vehicle(vehicle: RigidBody2D):
	if (self.nearby_vehicle == vehicle):
		self.nearby_vehicle = null
