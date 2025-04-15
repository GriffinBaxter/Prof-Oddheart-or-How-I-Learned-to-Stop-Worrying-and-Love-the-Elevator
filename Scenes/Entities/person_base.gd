extends RigidBody3D

@export var speed: float = 0.075

var in_elevator := false
var has_ever_entered_elevator := false
var direction: int = [-1, 1].pick_random()
var colour: Color = [Color.RED, Color.GREEN, Color.BLUE].pick_random()

@onready var left_ray: RayCast3D = $CollisionRayLeft
@onready var right_ray: RayCast3D = $CollisionRayRight
@onready var body: CSGMesh3D = $Body


func _ready() -> void:
	rotation_degrees.y = 90 * direction
	var material := StandardMaterial3D.new()
	material.albedo_color = colour
	body.material = material


func _process(_delta: float) -> void:
	handle_collision_outer_walls(left_ray)
	handle_collision_outer_walls(right_ray)


func _physics_process(delta: float) -> void:
	if in_elevator:
		set_collision_layer_value(1, false)
		set_collision_layer_value(2, true)
		var elevator := get_tree().root.get_child(0).find_child("Elevator")
		if elevator:
			global_position = elevator.global_position + elevator.get_current_velocity() * delta
	else:
		set_collision_layer_value(1, true)
		set_collision_layer_value(2, false)
		position.x += direction * speed


func enter_elevator() -> void:
	if !has_ever_entered_elevator:
		rotation.y = 0
		in_elevator = true
		has_ever_entered_elevator = true


func drop_off(corridor_colour: Color, new_direction: int) -> void:
	if corridor_colour == colour:
		direction = new_direction
		rotation_degrees.y = 90 if direction >= 0 else -90
		in_elevator = false
		get_tree().root.get_child(0).score += 100
		#think about what happens after dropoff
		#maybe they just dissapear when they hit the next wall or something
		#queue_free()


func die() -> void:
	queue_free()


func handle_collision_outer_walls(ray: RayCast3D) -> void:
	if ray.is_colliding():
		var col := ray.get_collider()
		if col != null:
			if col.is_in_group("outer_walls"):
				direction = -direction
				rotation_degrees.y = 90 if direction >= 0 else -90
