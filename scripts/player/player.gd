extends CharacterBody2D
class_name PlayerClass

const SPEED = 500

func _get_input():
	var input_direction = Input.get_vector("arrowkey_left", "arrowkey_right", "arrowkey_up", "arrowkey_down", 0.2)
	velocity = input_direction.normalized() * SPEED
	print_debug(velocity)	

func _physics_process(delta: float) -> void:
	_get_input()
	move_and_slide()
	
