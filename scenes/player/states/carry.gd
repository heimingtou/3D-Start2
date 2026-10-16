extends PlayerState

## Currently carrying something overhead.

func _enter() -> void:
	#Call obj.held.be_picked_up(obj.hold_point): the object becomes a child of HoldPoint but stays
	#where it was
	#Tween the object's position to Vector3.ZERO over 0.18 seconds to lift it from the ground into
	#hand
	#While lifting, the fox stands still and ignores input
	pass


func _exit() -> void:
	#Stop the lift tween if it's still running
	#If the hand is still full (got hit, died...), drop the object right where it is:
	#obj.held.be_dropped(obj.held.global_position), then obj.held = null
	pass


func _update(_delta: float) -> void:
	#Do nothing while still lifting
	#If "carry" is pressed -> obj.held.be_thrown(...), obj.held = null, then switch to state Throw
	#Otherwise move slower via move_by_input(0.6); change the animation to "carry" / "carry_idle"
	pass
