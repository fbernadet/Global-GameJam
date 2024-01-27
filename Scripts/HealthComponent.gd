extends Node2D

class_name HealthComponent

@export var health = 10
var parent

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()

func take_damage(dmg : int):
	health -= dmg
	print("Took damage :", dmg )
	if health<=0:
		# logique de mort
		print("mort")
