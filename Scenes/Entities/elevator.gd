extends CharacterBody3D

@export var speed: float = 10.


func _physics_process(_delta: float) -> void:
	var input := Input.get_vector("left", "right", "forward", "backward")
	var direction := transform.basis * Vector3(input.x, 0, input.y).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	if Input.is_action_pressed("up"):
		velocity.y = speed
	elif Input.is_action_pressed("down"):
		velocity.y = -speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
