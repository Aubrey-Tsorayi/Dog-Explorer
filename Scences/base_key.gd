extends Node2D

@onready var anim = $Key
@export var value: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("float")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pick_up_key_area_body_entered(body):
	if body is Player:
		GameController.key_collected(value)
		self.queue_free()
