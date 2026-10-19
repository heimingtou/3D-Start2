extends EnemyState
@export var shoot_interval: float = 1.5

func _enter() -> void:
	obj.change_animation("fly")
	timer = shoot_interval

func _update(_delta: float) -> void:
	if update_timer(_delta):
		change_state(fsm.states.shoot)
	var step: Vector3 = obj.forward() * obj.movement_speed
	obj.velocity.x = step.x
	obj. velocity.z = step.z
	if step.x > 0.0:
		obj.change_direction("right")
	elif step.x < 0.0:
		obj.change_direction("left")
	if _should_turn_around():
		obj. turn_around()

func _should_turn_around() -> bool:
	if obj.is_touch_wall():
		return true
	if  obj.is_can_fall():
		return true
	return false
	
	
	
	


		
