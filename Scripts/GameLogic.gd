extends Node2D

@onready var player = $"../Player"
@onready var goal = $"../Goal"
@onready var start = $"../Start"
@onready var colorRect = $"../ColorRect"
@onready var SpawnTimer = $Timer
@onready var clown = preload("res://Scenes/clown.tscn")
var day = 0
var already_dialogue = false

# Called when the node enters the scene tree for the first time.
func _ready():
	updateTimer()
	change_filter_value(1)
	player.position = start.global_position
	update_day_label()
	
func updateTimer():
	SpawnTimer.stop()
	print(float(easeInInverseXSquare(day)))
	SpawnTimer.wait_time = float(easeInInverseXSquare(day))
	print(SpawnTimer.wait_time)
	SpawnTimer.start()
	
func change_filter_value(value : float):
	var shader = colorRect.material as ShaderMaterial
	shader.set_shader_parameter("hp_percent", value)

func get_day_label():
	var camera = player.get_node("Camera2D")
	if camera and camera.has_node("DayLabel"):
		var daylabel = camera.get_node("DayLabel")
		return daylabel

func update_day_label():
	var day_label = get_day_label()
	day_label.text = "Day "+str(day)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if already_dialogue == false:
		already_dialogue = true
		var resource = load("res://Dialogues/main.dialogue")
		DialogueManager.show_dialogue_balloon(resource, "start")
		

func _on_goal_body_entered(body):
	if body.is_in_group("player"):
		print("Goal Acheived")
		# Logique de fin de jeux
		next_day()
		
func next_day():
	# TODO transmettre l'information du jour à l'UI
	# TODO transition un peu smooth pour le jour suivant
	player.set_is_tuto(false)	
	free_all_clowns()
	player.position = start.position
	day += 1
	updateTimer()
	update_day_label()
	print("jour = ", day)

func initial_dialogue():
	var resource = load("res://Dialogues/main.dialogue")
	DialogueManager.show_dialogue_balloon(resource, "start")
	
func spawn_enemy_at_camera_edge():
	var camera = get_viewport().get_camera_2d()
	var cam_pos = camera.global_position
	var cam_size = camera.get_viewport_rect().size
	
	var spawn_position = cam_pos
	spawn_position.x += randf_range(-cam_size.x / 2 - 50, cam_size.x / 2 + 50)
	spawn_position.y += randf_range(-cam_size.y / 2 - 50, cam_size.y / 2 + 50)
	
	var enemy = clown.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	enemy.global_position = spawn_position
	add_child(enemy)
	
func free_all_clowns():
	var nodes_in_group = get_tree().get_nodes_in_group("clown")
	for node in nodes_in_group:
		node.queue_free()

func _on_timer_timeout():
	spawn_enemy_at_camera_edge()

func _on_player_damage_taken_relay(hp):
	var hp_value = float(hp)/100.
	print(hp_value)
	change_filter_value(hp_value)

func _on_spawn_zone_body_exited(player : Player):
	player.set_is_tuto(false)
	
func easeInInverseXSquare(x :float):
	if x<=0:
		return 10000
	return float(1/(x*x))
