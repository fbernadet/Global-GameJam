class_name Clown
extends CharacterBody2D

var speed = 50
var player: Player = null
var direction: Vector2 = Vector2(0, 0)
var adjacent_clowns = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_list = get_tree().get_nodes_in_group("player")
	if not player_list.is_empty():
		player = player_list[0]

func _physics_process(delta):
	var distance = 0
	if player != null:
		distance = position.distance_to(player.position)
		direction = (player.position - position)
	
	for c in adjacent_clowns:
		direction += (position - c.position)
	direction = direction.normalized()
	
	print(distance)
	if (distance > 8):
		velocity = direction * speed
		move_and_slide()

func _on_detection_zone_body_entered(body: Node):
	var clown = body as Clown
	if not clown:
		return
	adjacent_clowns.append(clown)

func _on_detection_zone_body_exited(body):
	var clown = body as Clown
	if not clown:
		return
	adjacent_clowns.erase(clown)
