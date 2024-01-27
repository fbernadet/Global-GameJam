extends Node2D

@onready var player = $"../Player"
@onready var goal = $"../Goal"
@onready var start = $"../Start" 
@onready var clown = preload("res://Scenes/clown.tscn")
var day = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	player.position = start.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	pass


func _on_goal_body_entered(body):
	if body.is_in_group("player"):
		print("Goal Acheived")
		# Logique de fin de jeux
		next_day()
		
	
func next_day():
	# TODO transmettre l'information du jour à l'UI
	# TODO transition un peu smooth pour le jour suivant
	player.position = start.position
	day += 1
	print("jour = ", day)
	
func spawn_enemy_at_camera_edge():
	var camera = get_viewport().get_camera_2d()
	var cam_pos = camera.global_position
	var cam_size = camera.get_viewport_rect().size
	
	var spawn_position = cam_pos
	spawn_position.x += randf_range(-cam_size.x / 2 - 50, cam_size.x / 2 + 50)
	spawn_position.y += randf_range(-cam_size.y / 2 - 50, cam_size.y / 2 + 50)
	
	var enemy = clown.instantiate(PackedScene.GEN_EDIT_STATE_MAIN)
	enemy.global_position = spawn_position
	add_child(enemy)

func _on_timer_timeout():
	spawn_enemy_at_camera_edge()
