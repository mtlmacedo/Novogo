extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -550.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var motion = Vector2.ZERO
func sprite_handler(direction):
	
	if direction > 0:
		print("direita", direction)
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("run")
	elif direction < 0:
		print("esquerda", direction)
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("run")
	else :
		$AnimatedSprite2D.play("idle")
		
func _process(delta):
	# Add the gravity.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == 0 :
		velocity.x = direction * SPEED
	elif direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	sprite_handler(direction)
	
	if not is_on_floor():
		velocity.y += gravity * delta
		$AnimatedSprite2D.play("jump")
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	
	move_and_slide()
