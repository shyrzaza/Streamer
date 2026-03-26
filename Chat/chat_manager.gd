extends VBoxContainer

var chat_scene = preload("res://Chat/chat_message.tscn")
var nice_messages: StringProvider
var toxic_messages: StringProvider
var usernames: StringProvider
var username_colors: Array[Color] = [
		Color.from_rgba8(0, 0, 255), Color.from_rgba8(255, 0, 0),
		Color.from_rgba8(138, 43, 226), Color.from_rgba8(255, 105, 180),
		Color.from_rgba8(30, 144, 255), Color.from_rgba8(0, 128, 0),
		Color.from_rgba8(0, 255, 127), Color.from_rgba8(178, 34, 34),
		Color.from_rgba8(218, 165, 32), Color.from_rgba8(255, 69, 0),
		Color.from_rgba8(46, 139, 87), Color.from_rgba8(95, 158, 160),
		Color.from_rgba8(210, 105, 30)
	] 

class StringProvider:
	var messages = []
	var used_messages = []
	
	func _init(file_path):
		var json_as_text = FileAccess.get_file_as_string(file_path)
		messages = JSON.parse_string(json_as_text)
		messages.shuffle()
	
	func reshuffle_messages() -> void:
		var copy_ref = used_messages
		used_messages = messages
		messages = copy_ref
		messages.shuffle()
	
	func get_new_string() -> String:
		if messages.size() == 0:
			reshuffle_messages()
		
		var result = messages.pop_front()
		used_messages.push_back(result)
		
		return result


func create_chat_message(chanceForToxic: float) -> String:
	# Make sure the chanceForToxic is somewhere between 0.0 and 1.0
	assert(0.0 <= chanceForToxic)
	assert(chanceForToxic <= 1.0)
	
	# Add Username
	var color: Color = username_colors.pick_random()
	var message = "[color=%s]%s[/color]: " % [color.to_html(), usernames.get_new_string()]
	
	# Roll the RNG to check if the message is toxic
	if randf() > chanceForToxic:
		message += create_nice_chat_message()
	else: 
		message += create_toxic_chat_message()
		
	return message

func create_nice_chat_message() -> String:
	return nice_messages.get_new_string()
	
func create_toxic_chat_message() -> String:
	return toxic_messages.get_new_string()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nice_messages = StringProvider.new("res://Chat/nice_chat_messages.json")
	toxic_messages = StringProvider.new("res://Chat/toxic_chat_messages.json")
	usernames = StringProvider.new("res://Chat/usernames.json")


var CHAT_MESSAGE_TIME = 0.1
var elapsed_time = 0.0
var TOXIC_CHANCE = 0.25

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta
	
	if elapsed_time >= CHAT_MESSAGE_TIME:
		var new_chat_message: RichTextLabel = chat_scene.instantiate()
		add_child(new_chat_message)
		new_chat_message.text = create_chat_message(TOXIC_CHANCE)
		
		elapsed_time -= CHAT_MESSAGE_TIME
