class_name Player
extends BaseCharacter
@export var bullet_speed: float = 12.0
@onready var bullet_factory: Node3DFactory = $Direction/BulletFactory
## Turned on throughout the Hurt state so one hit doesn't drain health every single frame in a row.
var is_invulnerable: bool = false
var held: Node3D=null
var is_hold:bool=false
@onready var hold_point: Marker3D = $HoldPoint


func _ready() -> void:
	print('play')
	fsm = FSM.new(self, $States, $States/Idle)
	super._ready()


## Every state of the fox can take damage, so this calls straight into the current state; whichever
## state doesn't want to lose health (Dead) overrides take_damage().
func _on_hurt_area_3d_hurt(_direction: Vector3, damage: float) -> void:

	if is_invulnerable:
		return
	fsm.current_state.take_damage(int(damage))


func _on_area_3d_body_entered(body: Node3D) -> void:
	
	if body.has_method("be_picked_up") and held == null:
		held=body
	pass # Replace with function body.


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == held and not is_hold:
		held=null
	pass # Replace with function body.
func fire() -> void:
	print("fire")
	var bullet := bullet_factory.create() as RigidBody3D
	bullet.apply_impulse(forward()*bullet_speed)
