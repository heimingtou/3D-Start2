extends EnemyState


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update(delta: float) -> void:
	# Lấy trọng lực của dự án (hoặc tự định nghĩa số âm như -9.8 * 2)
	var gravity = 24
	
	# Nếu enemy chưa chạm đất, trừ dần vận tốc Y xuống để tạo đường cong rơi xuống
	if not obj.is_on_floor():
		obj.velocity.y -= gravity * delta
	else:
		# Khi chạm đất, có thể dừng lại hoặc chuyển về trạng thái Idle/Die tùy ý
		obj.velocity = Vector3.ZERO
		fsm.change_state(fsm.states.run)
		# change_state(fsm.states.idle)

	# Cho phép enemy di chuyển theo velocity đã tính toán
	obj.move_and_slide()
