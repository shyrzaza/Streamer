extends Node2D


var spawn_time = 3.0
#var obstacles: Array[RigidBody2D]

var obstacle_scene = preload("res://StreamGame/obstacle.tscn")
var time_to_spawn_next_obstacle = spawn_time
var left_spawn_border = 400
var right_spawn_boarder = 800

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Every now and then, spawn a rock at a random location
	time_to_spawn_next_obstacle -= delta
	
	if time_to_spawn_next_obstacle < 0:
		# Spawn
		var new_obstacle = obstacle_scene.instantiate()
		new_obstacle.position = Vector2(randf_range(left_spawn_border, right_spawn_boarder), -100)
		add_child(new_obstacle)
		pass
		time_to_spawn_next_obstacle = spawn_time
	pass
