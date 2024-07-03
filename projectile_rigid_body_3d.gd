extends RigidBody3D

@export var speed:float = 5.0
@export var damage:float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_and_collide(-transform.basis.z * delta * speed)
	pass


func _on_hit_area_3d_body_entered(body):
	print("Hit" + body.name)
	if body.is_in_group("Target"):
		print("Boom")
		body.queue_free()
		queue_free()
	pass # Replace with function body.


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
