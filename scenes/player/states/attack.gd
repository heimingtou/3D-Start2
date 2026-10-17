extends PlayerState

@export var KNOCKFRONT_SPEED:float=1.0
@export var HOP_SPEED:float=5.0

func _enter() -> void:
	obj. change_animation("attack")
	
	var push: Vector3 = obj. forward() * KNOCKFRONT_SPEED
	obj. velocity.x = push. x
	obj.velocity.z = push. z
	obj.velocity.y = HOP_SPEED

	#obj.stop_horizontal()
	timer = obj.anim_player.get_animation("attack_%s" % obj.direction).length
	_hit_shape().disabled = false

func _exit() -> void:
	_hit_shape().disabled = true
	
#func _update(_delta: float) -> void:
	#if update_timer(_delta):
		#change_state(fsm.previous_state)

func _hit_shape() -> CollisionShape3D:
	return obj.get_node("Direction/HitArea3D/CollisionShape3D")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name.begins_with("attack"):
		change_state(fsm.previous_state) # Replace with function body.
