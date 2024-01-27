class_name Player
extends CharacterBody2D

const speed = 300.0
const friction = 0.35

func _physics_process(delta):
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
