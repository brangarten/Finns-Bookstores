extends CharacterBody2D
class_name Player

var speed : int = 250

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _get_input():
	var input_direction = Input.get_vector("arrowkey_left", "arrowkey_right", "arrowkey_up", "arrowkey_down", 0.2)
	velocity = input_direction.normalized() * speed

	if Input.is_action_pressed("sprint"):
		speed = 400
	else:
		speed = 250

	if input_direction.x > 0:
		sprite.flip_h = false
	elif input_direction.x < 0:
		sprite.flip_h = true
	
func _physics_process(delta: float) -> void:
	sprite.play("moving")
	_get_input()
	move_and_slide()
	

	if Input.is_action_pressed("arrowkey_down"):
		GPlayer.value += .25
	
