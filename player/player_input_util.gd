extends Node


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
