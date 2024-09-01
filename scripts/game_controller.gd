extends Node

var total_keys: int = 0

func key_collected(value: int):
	total_keys += value
	EventController.emit_signal("key_collected", total_keys)
