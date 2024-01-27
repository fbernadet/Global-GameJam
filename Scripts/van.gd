extends enemy_movement

# Called when the node enters the scene tree for the first time.
func _ready():
	random_direction() # Replace with function body.




func _on_timer_timeout():
	random_generation()
	
	$Timer.start()
