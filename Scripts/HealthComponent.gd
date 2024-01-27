extends Node2D

class_name HealthComponent

@export var health = 100
@onready var progess_bar = $"../Camera2D/TextureProgressBar"
var parent

# Called when the node enters the scene tree for the first time.
func _ready():
	update_bar()
	parent = get_parent()
	
func update_bar():
	progess_bar.value = health	

func take_damage(dmg : int):
	health -= dmg
	print("Took damage :", dmg )
	update_bar()
	if health<=0:
		# logique de mort
		print("mort")
