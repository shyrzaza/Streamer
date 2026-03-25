extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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
	# For now it would be easiest to have a long list of chat messages that is returned
	
	return ""
	
func create_toxic_chat_message() -> String:
	return ""
	
