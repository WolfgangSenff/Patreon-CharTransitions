extends CharacterBody2D

const MoveSpeed = 120.0
const JumpVelocity = -280.0

var facing_direction: Vector2

func _physics_process(delta: float) -> void:
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if not is_zero_approx(x_input):
		facing_direction = Vector2(sign(x_input), 0)
		velocity.x = MoveSpeed * facing_direction.x
	else:
		velocity.x = 0.0
		
	velocity += Vector2.DOWN * delta * 600.0 # Just picking a gravity for simplicity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JumpVelocity
		
	move_and_slide()
