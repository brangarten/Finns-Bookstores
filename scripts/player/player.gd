extends CharacterBody2D
class_name Player

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

var speed : int = 250

func _get_input():

	# Grab direction and multiply it by the speed
	var input_direction = Input.get_vector("arrowkey_left", "arrowkey_right", "arrowkey_up", "arrowkey_down", 0.2)
	velocity = input_direction.normalized() * speed

	# Set speed depending if player is sprinting
	if Input.is_action_pressed("sprint"):
		speed = 400
	else:
		speed = 250

	# Flip on the y-axis depending on the direction
	if input_direction.x > 0:
		sprite.flip_h = false
	elif input_direction.x < 0:
		sprite.flip_h = true
	
func _physics_process(delta: float) -> void:
	# Check if player is near any island
	var is_near_island = false
	var islands = get_tree().get_nodes_in_group("islands")
	for island in islands:
		if island is Island and island.player_nearby: # Set true if player is inside the radius of an idea
			is_near_island = true
			break
	
	# Play "land" animation when near island, otherwise play "moving"
	if is_near_island:
		sprite.play("land")
	else:
		sprite.play("moving")
	
	_get_input()
	move_and_slide()
	
