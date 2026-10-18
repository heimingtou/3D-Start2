
extends EnemyCharacter

func _ready() -> void:
	fsm = FSM.new(self, $States, $States/Run)
	super._ready()

func be_picked_up(hold_point: Node3D) -> void:
	if has_node("CollisionShape3D"):
		$CollisionShape3D.disabled = true
	set_physics_process(false)
	var current_global_pos = global_position
	get_parent().remove_child(self)
	hold_point.add_child(self)
	global_position = current_global_pos # Giữ nguyên vị trí thế giới trước khi Tween kéo lên
	print("chang state carried")
	
func be_throw(throw_direction: Vector3) -> void:
	if has_node("CollisionShape3D"):
		$CollisionShape3D.disabled = false
		
	set_physics_process(true)
	
	# 1. LƯU LẠI VỊ TRÍ VÀ SCENE HIỆN TẠI TRƯỚC KHI GỠ KHỎI PARENT CŨ
	var current_global_pos = global_position
	var main_scene = get_tree().current_scene
	
	# 2. Gỡ khỏi parent cũ (HoldPoint của Player)
	var current_parent = get_parent()
	if current_parent:
		current_parent.remove_child(self)
		
	# 3. Thêm trở lại vào Scene chính
	if main_scene:
		main_scene.add_child(self)
		# Gán lại vị trí cũ khi đã ở trong Scene chính an toàn
		global_position = current_global_pos
		
		# (Tùy chọn) Thêm lực bay đi theo hướng throw_direction nếu muốn
	velocity = throw_direction * 12.0  # Tốc độ bay ngang
	velocity.y = 6.0
	fsm.change_state(fsm.states.throw)
