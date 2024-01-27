class_name Player
extends CharacterBody2D
@onready var _animated_sprite = $AnimatedSprite2D
const speed = 100.0
const friction = 0.35

func _physics_process(_delta):
	var direction := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	if direction.length() > 1.0:
		direction = direction.normalized()

	var target_velocity = direction * speed
	velocity += (target_velocity - velocity) * friction
	move_and_slide()
	
func _input(event):
	if event.is_action_pressed("special"):
		print("YES")

func _process(_delta):
	if Input.is_action_pressed("ui_up"):
		_animated_sprite.play("run_arriere")

	if Input.is_action_pressed("ui_down"):
		_animated_sprite.play("run_avant")
		
	if Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right"):
		_animated_sprite.play()
		
	if Input.is_action_pressed("ui_left") == false && Input.is_action_pressed("ui_right") == false && Input.is_action_pressed("ui_up") == false && Input.is_action_pressed("ui_down") == false:
		_animated_sprite.stop()
