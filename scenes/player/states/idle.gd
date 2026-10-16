extends PlayerState

func _enter() -> void:
	obj.change_animation("idle")

# scenes/player/states/idle.gd
func _update(_delta: float) -> void:
	if control_attack():
		return

	control_jump()
	control_moving()
	if not obj.is_on_floor():
		change_state(fsm.states.fall)
