
extends EnemyCharacter
var is_throwing:bool=false
var hold_speed: float=0.6
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
	global_position = current_global_pos
	print("chang state carried")
	fsm.change_state(fsm.states.carried)
	
func be_throw(throw_direction: Vector3) -> void:
	if has_node("CollisionShape3D"):
		$CollisionShape3D.disabled = false		
	set_physics_process(true)
	var current_global_pos = global_position
	var main_scene = get_tree().current_scene
	var current_parent = get_parent()
	if current_parent:
		current_parent.remove_child(self)
	if main_scene:
		main_scene.add_child(self)
		global_position = current_global_pos
	velocity = throw_direction * 12.0  
	velocity.y = 6.0
	fsm.change_state(fsm.states.throw)
