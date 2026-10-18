extends EnemyState

func _enter() -> void:
	print("change state")
	obj.change_animation("idle")
	
