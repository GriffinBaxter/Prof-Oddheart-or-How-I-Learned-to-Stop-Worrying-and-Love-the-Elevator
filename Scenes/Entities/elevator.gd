extends CharacterBody3D

@export var speed: float = 10.


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(_delta: float) -> void:
	var input := Input.get_vector("left", "right", "down", "up")
	var direction := transform.basis * Vector3(input.x, input.y, 0).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	velocity.z = speed * Input.get_last_mouse_velocity().y * 0.001

	move_and_slide()
