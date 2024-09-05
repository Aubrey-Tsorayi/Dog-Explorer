extends Path2D

@export var loop: bool = true
@export var speed: float = 2.0
@export var speed_scale: float = 1.0

@onready var path = $PathFollow2D
@onready var anim = $AnimationPlayer

func _ready() -> void:
	if not loop:
		anim.play("move")
		anim.speed_scale = speed_scale
		set_process(false)

func _process(delta: float) -> void:
	path.progress += speed
	



func _on_spike_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
