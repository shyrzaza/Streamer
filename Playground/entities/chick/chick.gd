extends RigidBody2D

var dragging := false
var drag_offset := Vector2.ZERO




			
func _input_event(viewport, event, shapeidx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		print("Clicked")
		if event.pressed:
			start_drag(get_global_mouse_position())

func _input(event):
	# 2. Listen to the release ANYWHERE in the game window
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed and dragging:
			stop_drag()
			
	
func start_drag(mouse_pos):
	dragging = true
	freeze = true
	freeze_mode = RigidBody2D.FREEZE_MODE_STATIC
	
	var chick_pos = global_position
	drag_offset = global_position - mouse_pos
	linear_velocity = Vector2.ZERO
	angular_velocity = 0

func stop_drag():
	dragging = false
	freeze = false
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Chick ready")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Drag the Chick from the sling
	# with a max distance

	# On release, apply a force based on the distance between the chick 
	# and the sling 
	pass

func _physics_process(delta):
	if dragging:
		global_position = get_global_mouse_position() + drag_offset
		
	if Input.is_action_just_pressed("ui_accept"):
		apply_impulse(Vector2.UP * 300)
		
