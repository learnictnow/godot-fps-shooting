extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var mouse_sensitivity = 0.002

@export var projectile:PackedScene

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event):
	# If escape pressed load level select scene
		
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$CameraPivotMarker3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$CameraPivotMarker3D.rotation.x = clampf($CameraPivotMarker3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))
		
	
	if event.is_action_pressed("fire_primary"):
		primary_fire()
		
		
func primary_fire():
	print("Pew pew")
	var tmp_bullet = projectile.instantiate()
	tmp_bullet.position = $CameraPivotMarker3D/BulletSpawnMarker3D.global_position
	tmp_bullet.rotation = $CameraPivotMarker3D/BulletSpawnMarker3D.global_rotation
	add_sibling(tmp_bullet)
	
