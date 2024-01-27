extends CharacterBody2D

var speed = 100
var player: Player = null
var direction: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("player")[0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	direction = (player.position - position).normalized()
	velocity = direction * speed 
	move_and_slide()
