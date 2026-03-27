extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var leftSideBorder = 370
var rightSideBorder = 800
@export var performance = 0

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Check boundaries
	if position.x < leftSideBorder:
		velocity.x = max(velocity.x, 0)
	if position.x > rightSideBorder:
		velocity.x = min(velocity.x, 0)
		
	move_and_slide()
	
func tank_performance(amount: int) -> void:
	print("Oh no my performance tanked")
	performance -= amount
