extends RichTextLabel

var color
var username
var message
var is_toxic
var point_callable: Callable
var banned = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var node_position = get("position")
	if node_position.y <= 0:
		if is_toxic == banned:
			point_callable.call(10)
		else:
			point_callable.call(-10)
		self.queue_free()

func set_point_callable(point_callable: Callable):
	self.point_callable = point_callable
	

func set_message(color: Color, username: String, message: String, is_toxic: bool) -> void:
	self.color = color
	self.username = username
	self.message = message
	self.is_toxic = is_toxic

	self.text = "[color=%s]%s[/color]: %s" % [color.to_html(), username, message]

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("Ban"):
		set_message(color, "deleted", "This message has been deleted.", is_toxic)
		banned = true
