extends PlayerState

## Currently carrying something overhead.
var lift_tween: Tween = null
func _enter() -> void:
	if not obj.held:
		change_state(fsm.states.idle)
		return
	print("nhat do")
	if obj.held != null:
		obj.held.be_picked_up(obj.hold_point)
	obj.is_hold=true
	var old_global_pos = obj.held.global_position
	obj.held.global_position = old_global_pos
	
	lift_tween = create_tween()
	lift_tween.set_ease(Tween.EASE_OUT)
	lift_tween.set_trans(Tween.TRANS_QUAD)
	lift_tween.tween_property(obj.held, "position", Vector3.ZERO, 0.18)
	obj.change_animation("carry")
	# Khi tween chạy xong (hết 0.18 giây) thì mở khóa cho phép di chuyển và nhận input trở lại
	
	
	


func _exit() -> void:
	
	
	#Stop the lift tween if it's still running
	#If the hand is still full (got hit, died...), drop the object right where it is:
	#obj.held.be_dropped(obj.held.global_position), then obj.held = null
	pass


func _update(_delta: float) -> void:
	
	if Input.is_action_just_pressed("carry"):
		print("throw")
		var throw_dir = obj.forward()
		throw_dir=throw_dir.normalized()
		obj.held.be_throw(throw_dir)
		obj.is_hold=false
		change_state(fsm.states.throw)
	var is_moving=move_by_input(0.6)
	if is_moving:
		obj.change_animation("carry_run")
	else:
		obj.change_animation("carry")
	
	#Do nothing while still lifting
	#If "carry" is pressed -> obj.held.be_thrown(...), obj.held = null, then switch to state Throw
	#Otherwise move slower via move_by_input(0.6); change the animation to "carry" / "carry_idle"
	pass
