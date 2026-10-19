extends EnemyState


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update(delta: float) -> void:
	
	var gravity = 24
	
	
	if not obj.is_on_floor():
		obj.velocity.y -= gravity * delta
	else:	
		obj.velocity = Vector3.ZERO
		fsm.change_state(fsm.states.run)
