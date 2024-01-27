extends CharacterBody2D

class_name enemy_movement

const speed = 10.0
var dir

var current_states
enum enemy_state {MOVERIGHT,MOVELEFT,MOVEUP,MOVEDOWN}



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func move_right():
	velocity=Vector2.RIGHT*speed

func move_left():
	velocity=Vector2.LEFT*speed

func move_up():
	velocity=Vector2.UP*speed

func move_down():
	velocity=Vector2.DOWN*speed

func random_generation():
	dir=randi()%4
	random_direction()


func _physics_process(delta):

	match current_states:
		enemy_state.MOVEDOWN:
			move_down()

		enemy_state.MOVEUP:
			move_up()

		enemy_state.MOVERIGHT:
			move_right()

		enemy_state.MOVELEFT:
			move_left()

	move_and_slide()

func random_direction():
	match dir:
		0:
			current_states = enemy_state.MOVERIGHT
		1:
			current_states = enemy_state.MOVELEFT
		2:
			current_states = enemy_state.MOVEUP
		3:
			enemy_state.MOVEDOWN
