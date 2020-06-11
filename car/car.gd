extends RigidBody2D

export var speed: float = 5000
export var reverse_speed: float = 2000
export var drive_zoom: float = 1.5
export var locked: float = false
export var turning_speed: float = 7

var default_zoom = null
var camera: Camera2D = null
var driver: KinematicBody2D = null
onready var road_map: TileMap = get_parent().get_node("Road")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_direction() -> Vector2:
	var direction = Vector2(0, 0);
	
	if Input.is_action_pressed("up"):
		direction.y -= 1
	
	if Input.is_action_pressed("down"):
		direction.y += 0.5
	
	return direction.rotated(rotation)#.normalized()

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

func damp():
	var vel = linear_velocity.rotated(-rotation)
	
	# General damping
	vel *= 0.99
	
	# Damp the sideways velocities a lot more
	vel.x *= 0.95
	vel = vel.rotated(rotation)
	linear_velocity = vel

func _physics_process(delta):
	damp()
	
	
	if !self.driver:
		return
	
	# Remove the driver from the car if they want to leave
	if Input.is_action_just_pressed("enter_vehicle"):
		remove_driver()
		
	var direction: Vector2 = get_direction()
	
	# Slow the car down if we are not on a road
	if road_map.get_cellv(road_map.world_to_map(global_position)) == TileMap.INVALID_CELL:
		direction *= 0.6

	# Move the car in the direction it is facing
	apply_central_impulse(direction * delta * speed)
	
	# Rotate the car in the direction the user is pressing only if the car
	# is currently moving
	if linear_velocity.abs().length() > 0.01:
		apply_torque_impulse(get_steering() * delta * 10000 * turning_speed)


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
	if body.has_method("add_nearby_vehicle") and not locked:
		body.add_nearby_vehicle(self)

func _on_DetectionArea_body_exited(body):
	if body.has_method("remove_nearby_vehicle"):
		body.remove_nearby_vehicle(self)
