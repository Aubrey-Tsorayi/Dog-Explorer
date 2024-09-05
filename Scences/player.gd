class_name Player extends CharacterBody2D

# add animation
@onready var anim = $AnimatedSprite2D

@export var SPEED : int = 300.0
@export var JUMP_VELOCITY : float = -400.0
@export var push_force: float = 80.0

var can_control : bool = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	anim.play("idle")

func _physics_process(delta):
	if not can_control : return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		anim.play("jump")

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction == 1:
			anim.flip_h = false
		else:
			anim.flip_h = true
		
		if is_on_floor():
			anim.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			anim.play("idle")

	move_and_slide()
	
	# crate collisions
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
	
	#global_position = global_position.clamp(Vector2.ZERO, Vector2(800, 270))

func die() -> void:
	set_physics_process(false)
	anim.play("death")
	if anim.animation_finished :
		visible = false
		can_control= false
	
	await  get_tree().create_timer(1).timeout
	reset_player()
	
func reset_player()->void:
	GameController.total_keys = 0
	get_tree().reload_current_scene()
	visible = true
	can_control = true
