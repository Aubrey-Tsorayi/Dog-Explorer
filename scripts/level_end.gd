extends Area2D

@onready var audio = $AudioStreamPlayer2D
@onready var anim = $AnimatedSprite2D
const FILE_BEGIN = "res://levels/level"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	anim.play("closed")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameController.total_keys > 0:
		anim.play("open")
		audio.play()
		$CollisionShape2D.set_deferred("disabled", false)
	

func _on_body_entered(body: Node2D) -> void:
	print("Player entered")
	if body is Player:
		var curret_level_file = get_tree().current_scene.scene_file_path
		var next_level_number = curret_level_file.to_int() + 1
		var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
		
		if next_level_number == 7:
			get_tree().change_scene_to_file("res://Scences/main_menu.tscn")
		else:
			get_tree().change_scene_to_file(next_level_path)
