extends RigidBody2D

export var speed: float = 5000
export var reverse_speed: float = 2000
export var drive_zoom = 1.5

var default_zoom = null
var camera: Camera2D = null
var driver: KinematicBody2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_direction() -> Vector2:
	var direction = Vector2(0, -1).rotated(rotation)
	return direction.normalized();

func get_steering() -> float:
	var direction = 0;
	if Input.is_action_pressed("right"):
		direction += 1
	
	if Input.is_action_pressed("left"):
		direction -= 1
		
	return direction

func remove_driver():
	print("Leaving the car")
	get_parent().add_child(self.driver)
	self.driver.global_position = $DoorPos.global_position

	if (self.camera):
		remove_child(self.camera)
		driver.add_child(self.camera)
		self.camera.zoom = self.default_zoom
		self.camera = null
	
	self.driver = null

func _physics_process(delta):
	if !self.driver:
		return
	
	# Remove the driver from the car if they want to leave
	if Input.is_action_just_pressed("enter_vehicle"):
		remove_driver()
	
	if !Input.is_action_pressed("up"):
		return
		
	var direction: Vector2 = get_direction()

	# Move the car in the direction it is facing
	apply_central_impulse(direction * delta * speed)
	
	# Rotate the car in the direction the user is pressing
	apply_torque_impulse(get_steering() * delta * 100000)


func add_driver(new_driver: KinematicBody2D):
	if driver:
		return false
	
	driver = new_driver
	new_driver.get_parent().remove_child(new_driver)
	self.camera = driver.get_node_or_null("Camera2D")
	if self.camera:
		driver.remove_child(self.camera)
		add_child(self.camera)
		self.default_zoom = self.camera.zoom
		self.camera.zoom = Vector2(self.drive_zoom, self.drive_zoom)
	return true


func _on_DetectionArea_body_entered(body):
	if body.has_method("add_nearby_vehicle"):
		body.add_nearby_vehicle(self)

func _on_DetectionArea_body_exited(body):
	if body.has_method("remove_nearby_vehicle"):
		body.remove_nearby_vehicle(self)
