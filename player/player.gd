extends KinematicBody2D


export var speed: float = 200

var nearby_vehicle = null;

func _process(delta):
	if Input.is_action_just_pressed("enter_vehicle"):
		print(nearby_vehicle)
		if (nearby_vehicle):
			print("Entering vehicle")
			self.nearby_vehicle.add_driver(self)


func get_direction() -> Vector2:
	var direction = Vector2()
	
	if Input.is_action_pressed("right"):
		direction.x += 1;
	
	if Input.is_action_pressed("left"):
		direction.x -= 1;
		
	if Input.is_action_pressed("up"):
		direction.y -= 1;
	
	if Input.is_action_pressed("down"):
		direction.y += 1;
	
	return direction.normalized();

func _physics_process(delta):
	var direction: Vector2 = get_direction()
	if direction.length() != 0:
		move_and_slide(direction * speed, Vector2(0, 0), false, 4, 0.785398, false)

	look_at(get_global_mouse_position())

func add_nearby_vehicle(vehicle: RigidBody2D):
	self.nearby_vehicle = vehicle

func remove_nearby_vehicle(vehicle: RigidBody2D):
	if (self.nearby_vehicle == vehicle):
		self.nearby_vehicle = null
