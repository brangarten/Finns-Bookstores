extends CharacterBody2D
class_name PlayerClass

const SPEED : int = 500

func _add_val(event):
	"""
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			Wallet.wallet_value += 2.25"""
	pass

func _get_input():
	var input_direction = Input.get_vector("arrowkey_left", "arrowkey_right", "arrowkey_up", "arrowkey_down", 0.2)
	velocity = input_direction.normalized() * SPEED
	print_debug(velocity)	

func _physics_process(delta: float) -> void:
	_get_input()
	_add_val(Input)
	move_and_slide()
	
