extends Node2D

var particles : CPUParticles2D
var emitter : Area2D

var particle_direction = Vector2(0, -1)
var is_shooting = false

@onready var maCollisionShape = $Area2D2/CollisionWater
var timer 

# Called when the node enters the scene tree for the first time.
func _ready():
	timer= Timer.new()
	add_child(timer)
	maCollisionShape.set_deferred("disabled", true)
	timer.wait_time=0.8
	particles = $CPUParticles2D
	emitter = $Area2D
	particles.emitting = false
	visible=false
	#emitter.connect("area_entered", self, "_on_particle_area_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	
	if Input.is_action_pressed("fire") and !is_shooting :
		
		timer.start()
		if maCollisionShape != null:
			maCollisionShape.set_deferred("disabled", false)
		is_shooting = true
		visible=true
		particles.emitting = true
		
		
	elif !Input.is_action_pressed("fire") and is_shooting:
		if maCollisionShape != null:
			maCollisionShape.set_deferred("disabled", true)
		is_shooting = false
		visible=false
		particles.emitting = false
		particles.restart()
	
	elif timer.time_left<0.2:
		maCollisionShape.set_deferred("disabled", true)

		

