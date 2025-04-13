extends RigidBody3D

const COLOURS = [Color.RED, Color.GREEN, Color.BLUE]

@export var speed: float = 5
@export var fall_speed: float = 1

var in_elevator: bool = false
var direction = [-1, 1]
var colour: Color

@onready var left_ray: RayCast3D = $CollisionRayLeft
@onready var right_ray: RayCast3D = $CollisionRayRight
@onready var body: CSGMesh3D = $Body


func _ready() -> void:
	direction = direction.pick_random()
	var material = StandardMaterial3D.new()
	material.albedo_color = COLOURS[randi_range(0, 2)]
	body.material = material


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

func die() -> void:
	queue_free()
