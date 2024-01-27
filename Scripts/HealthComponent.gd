extends Node2D

class_name HealthComponent

@export var health = 100
@onready var progess_bar = $"../Camera2D/TextureProgressBar"
var parent

signal is_dead
signal damage_taken(hp)

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
	emit_signal("damage_taken", health)
	if health<=0:
		# logique de mort
		emit_signal("is_dead")
		print("mort")

func _on_hurtbox_area_entered(area : Hitbox):
	take_damage(area.damage)
