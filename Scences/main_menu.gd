class_name MainMenu
extends Control

func _ready() -> void:
	$AnimatedSprite2D.play("run")


func _on_play_button_pressed():
	LevelManager.load_level(1)
	get_tree().change_scene_to_file("res://levels/level1.tscn")
	deactivate()


func _on_quit_button_pressed():
	get_tree().quit()

func deactivate() -> void:
	hide()
	set_process(false)
	set_physics_process(false)
	set_process_unhandled_input(false)
	set_process_input(false)
	
func activate() -> void:
	show()
	set_process(true)
	set_physics_process(true)
	set_process_unhandled_input(true)
	set_process_input(true)
