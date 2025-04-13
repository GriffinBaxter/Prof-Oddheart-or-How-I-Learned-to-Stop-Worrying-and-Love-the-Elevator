extends RigidBody3D

@export var speed: float = 5
@export var fall_speed: float = 1

var in_elevator: bool = false
var direction: int = 1

@onready var left_ray: RayCast3D = $CollisionRayLeft
@onready var right_ray: RayCast3D = $CollisionRayRight

func _ready() -> void:
	direction = randi_range(-1, 1)

func _process(_delta: float) -> void:
	if left_ray.is_colliding():
		var lef_coll = left_ray.get_collider()
		if lef_coll.is_in_group("outer_walls"):
			direction = direction * -1
	if right_ray.is_colliding():
		var right_coll = right_ray.get_collider()
		if right_coll.is_in_group("outer_walls"):
			direction = direction * -1

func _physics_process(delta: float) -> void:
	if !in_elevator:
		position.x += direction * speed * delta
