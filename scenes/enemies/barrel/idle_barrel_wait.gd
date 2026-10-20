extends EnemyState

## Stands still counting down, switches to Shoot once the timer's up.
## How often it fires, in seconds.
@export var shoot_interval: float = 1.5

func _enter() -> void:
	obj. change_animation("idle")

func _update(delta: float) -> void:
	if obj. found_player != null:
		obj.change_direction(BaseCharacter.direction_to(obj.global_position, obj. found_player.global_position))
		change_state(fsm.states.shoot)
		return
		
