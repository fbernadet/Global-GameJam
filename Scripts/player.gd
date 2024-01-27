class_name Player
extends CharacterBody2D
@onready var _animated_sprite = $AnimatedSprite2D
@onready var game_over_label = $Camera2D/GameOverLabel
const speed = 100.0
const friction = 0.35

signal damage_taken_relay(hp)

func _ready():
	game_over_label.visible = false

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

func _on_briefcase_body_entered(body):
	var clown = body as Clown
	if not clown:
		return
	clown.bounce((clown.position - position).normalized())


func _on_health_component_is_dead():
	game_over_label.visible = true
	get_tree().paused = true
	print("YOU DIED")

func _on_health_component_damage_taken(hp):
	emit_signal("damage_taken_relay", hp)
