extends Area2D

# A set of the nearby entities the user can interact with
var nearby: Dictionary = {}

func _on_body_entered(body: PhysicsBody2D):
    # Check to see if we can interact with that body
    if (body and body.is_in_group("interactable")):
        print("Nearby interactable entity")
        nearby[body] = true;


func _on_body_exited(body):
    if (body.is_in_group("interactable")):
        print("Left vicinity of interactable entity")
        if nearby.has(body):
            nearby.erase(body)

func interact():
    if (nearby.empty()):
        print("Attemping to interact but nothing to interact with")
        return
    
    var entity: PhysicsBody2D = nearby.keys()[0]
    
    if not entity.has_method("interact"):
        print("ERROR: Entity '" + entity.name + "' is not interactable")
        return
        
    print("Interacting with " + entity.name)
    return entity.interact()
