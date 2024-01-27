extends Node2D

var particles : CPUParticles2D
var emitter : Area2D

var particle_direction = Vector2(0, -1)
var is_shooting = false



# Called when the node enters the scene tree for the first time.
func _ready():
	particles = $CPUParticles2D
	emitter = $Area2D
	particles.emitting = false
	#emitter.connect("area_entered", self, "_on_particle_area_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	
	if Input.is_action_pressed("fire") and !is_shooting :
		is_shooting = true
		visible=true
		particles.emitting = true
		
		
	elif !Input.is_action_pressed("fire") and is_shooting:
		is_shooting = false
		visible=false
		particles.emitting = false
		particles.restart()
	
		

		

