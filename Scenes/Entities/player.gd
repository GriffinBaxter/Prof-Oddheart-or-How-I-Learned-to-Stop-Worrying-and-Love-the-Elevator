extends CharacterBody3D

@export var speed: float = 20.0
@export var accel: float = 5.0

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var direction: Vector3 = Vector3.ZERO
	var input: Vector2 = Input.get_vector("left", "right", "forward", "backward")

	if input.length() > 0:
		direction = (transform.basis * Vector3(input.x, 0, input.y).normalized())

	velocity.x = lerp(velocity.x, direction.x * speed, accel * delta)
	velocity.z = lerp(velocity.z, direction.z * speed, accel * delta)
	velocity.y = lerp(velocity.y, direction.y * speed, accel * delta)

	if Input.is_action_pressed("up"):
		velocity.y += speed * accel * delta
	if Input.is_action_pressed("down"):
		velocity.y -= speed * accel * delta

	move_and_slide()
