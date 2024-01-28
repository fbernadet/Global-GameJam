class_name Clown
extends CharacterBody2D

var NORMAL_SPEED = 50
var BOUNCE_SPEED = 150
var STUN_SPEED = 0
var speed = NORMAL_SPEED
var player: Player = null
var level: Level = null
var direction: Vector2
var is_bouncing = false
var is_stun = false
@onready var bouce_timer = $BounceTimer
@onready var stun_timer = $StunTimer
@onready var _animated_sprite = $clown1_animatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_list = get_tree().get_nodes_in_group("player")
	if not player_list.is_empty():
		player = player_list[0]
	var level_list = get_tree().get_nodes_in_group("logic")
	if not level_list.is_empty():
		level = level_list[0]

func _physics_process(delta):
	if not is_bouncing:
		direction = Vector2(0, 0)
		
		if player != null:
			var distance = position.distance_to(player.position)
			if distance > 500:
				_on_hurtbox_area_entered(null)
			
			direction = (player.position - position)
			if direction.x <= 0:
				_animated_sprite.play("Run_gauche")
			else:
				_animated_sprite.play("Run_droite")
			
		direction = direction.normalized()
	
	velocity = direction * speed
	move_and_slide()

func bounce(dir: Vector2):
	bouce_timer.start()
	is_bouncing = true
	speed = BOUNCE_SPEED
	direction = dir

func _on_bounce_timer_timeout():
	stun_timer.start()
	is_bouncing = false
	is_stun = true
	speed = STUN_SPEED

func _on_stun_timer_timeout():
	is_stun = false
	speed = NORMAL_SPEED

func _on_hurtbox_area_entered(area):
	if level != null:
		level.nb_ennemy -= 1
	queue_free()
