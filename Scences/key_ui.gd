extends Control

@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	EventController.connect("key_collected", on_event_key_collected)


func on_event_key_collected(value : int) -> void:
	label.text = str(value)
