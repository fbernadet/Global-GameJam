extends Node2D

@onready var player = $"../Player"
@onready var goal = $"../Goal"
@onready var start = $"../Start"

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
