extends VBoxContainer

var chat_scene = preload("res://Chat/chat_message.tscn")
var nice_messages: ChatDB
var toxic_messages: ChatDB

class ChatDB:
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
	
	func get_new_message() -> String:
		if messages.size() == 0:
			reshuffle_messages()
		
		var result = messages.pop_front()
		used_messages.push_back(result)
		
		return result


func create_chat_message(chanceForToxic: float) -> String:
	# Make sure the chanceForToxic is somewhere between 0.0 and 1.0
	assert(0.0 <= chanceForToxic)
	assert(chanceForToxic <= 1.0)
	
	# Roll the RNG to check if the message is toxic
	if randf() > chanceForToxic:
		return create_nice_chat_message()
	else: 
		return create_toxic_chat_message()

func create_nice_chat_message() -> String:
	return nice_messages.get_new_message()
	
func create_toxic_chat_message() -> String:
	return toxic_messages.get_new_message()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nice_messages = ChatDB.new("res://Chat/nice_chat_messages.json")
	toxic_messages = ChatDB.new("res://Chat/toxic_chat_messages.json")


var CHAT_MESSAGE_TIME = 3.0
var elapsed_time = 0.0
var TOXIC_CHANCE = 0.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta
	
	if elapsed_time >= CHAT_MESSAGE_TIME:
		var new_chat_message: RichTextLabel = chat_scene.instantiate()
		add_child(new_chat_message)
		new_chat_message.text = create_chat_message(TOXIC_CHANCE)
		
		elapsed_time -= CHAT_MESSAGE_TIME
