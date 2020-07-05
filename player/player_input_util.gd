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

func look_at_mouse(node: Node2D):
    node.look_at(node.get_global_mouse_position())

func interact_nearby(interaction_detection):
    if not Input.is_action_just_released("enter_vehicle"):
        return
    
    return interaction_detection.interact()
        
