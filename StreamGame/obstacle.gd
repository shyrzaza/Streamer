extends Area2D

var SPEED = 60
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += SPEED * delta
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.has_method("add_to_score"):
			body.add_to_score(20) #TODO TEST
