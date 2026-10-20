extends PlayerState

@export var shoot_delay: float = 0.2
@export var bullet_shoot: float=3.0
var _fire_timer: float = 0.0

var _count_bullet: float=0.0

func _enter() -> void:
	print("shoot")
	#obj.change_animation("shoot")
	obj.stop_move()
	_count_bullet=bullet_shoot
	_fire_timer = shoot_delay
# Length taken from the animation itself - see the same kind of notein the fox's Attack state.
	timer=0.6
	#timer = obj.anim_player.get_animation("shoot_%s" %obj.direction).length

func _update(delta: float) -> void:
	if _count_bullet>0:
		_fire_timer -= delta
		if _fire_timer <= 0.0:
			obj.fire()
			_count_bullet-=1
			_fire_timer=shoot_delay
	if update_timer(delta):
		change_state(fsm.states.idle)
