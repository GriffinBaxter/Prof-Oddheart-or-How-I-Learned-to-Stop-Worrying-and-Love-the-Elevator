extends CharacterBody3D

@export var speed := 10.
@export var elevator_strength := 2.


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


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

	for slide_collision_count in get_slide_collision_count():
		var slide_collision := get_slide_collision(slide_collision_count)
		var collider := slide_collision.get_collider()
		if slide_collision.get_collider() is RigidBody3D and not collider.is_in_group("elevator"):
			slide_collision.get_collider().apply_central_impulse(
				-slide_collision.get_normal() * 30. * elevator_strength
			)
			slide_collision.get_collider().apply_impulse(
				-slide_collision.get_normal() * elevator_strength, slide_collision.get_position()
			)


func get_current_velocity() -> Vector3:
	return velocity


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("people"):
		print("enter elevator called....")
		body.enter_elevator()
