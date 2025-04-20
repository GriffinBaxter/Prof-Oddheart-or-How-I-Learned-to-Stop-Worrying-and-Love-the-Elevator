extends RigidBody3D

const Conversations := preload("res://Scripts/conversations.gd")

@export var speed: float = 0.075

var in_elevator := false
var has_ever_entered_elevator := false
var direction: int = [-1, 1].pick_random()
var colour: Color = [Color.RED, Color.GREEN, Color.BLUE].pick_random()
var elevator: CharacterBody3D

@onready var left_ray: RayCast3D = $CollisionRayLeft
@onready var right_ray: RayCast3D = $CollisionRayRight
@onready var body: CSGMesh3D = $Body
@onready var elevator_ding: AudioStreamPlayer = $ElevatorDing
@onready var conversation_player: AudioStreamPlayer3D = $ConversationPlayer


func _ready() -> void:
	rotation_degrees.y = 90 * direction
	var material := StandardMaterial3D.new()
	material.albedo_color = colour
	body.material = material
	elevator = get_tree().root.get_child(2).find_child("Elevator")


func _process(_delta: float) -> void:
	handle_collision_outer_walls(left_ray)
	handle_collision_outer_walls(right_ray)


func _physics_process(delta: float) -> void:
	if in_elevator:
		set_collision_layer_value(1, false)
		set_collision_layer_value(2, true)
		if elevator:
			global_position = elevator.global_position + elevator.velocity * delta
	else:
		set_collision_layer_value(1, true)
		set_collision_layer_value(2, false)
		position.x += direction * speed


func enter_elevator() -> void:
	if !has_ever_entered_elevator:
		in_elevator = true
		has_ever_entered_elevator = true
		elevator.people_in_elevator.append(self)

		var target_y = elevator.rotation.y
		var tween := create_tween()
		(
			tween
			. tween_property(self, "rotation:y", target_y, 0.5)
			. set_trans(Tween.TRANS_SINE)
			. set_ease(Tween.EASE_OUT)
		)

		if !elevator_ding.playing or elevator_ding.get_playback_position() >= 2:
			elevator_ding.play()


func drop_off(corridor_colour: Color, new_direction: int) -> void:
	if corridor_colour == colour:
		direction = new_direction
		rotation_degrees.y = 90 if direction >= lerp(0, 90, 1) else lerp(0, -90, 1)
		in_elevator = false
		get_tree().root.get_child(2).score += 100
		elevator.people_in_elevator.remove_at(elevator.people_in_elevator.find(self))
		if !elevator_ding.playing or elevator_ding.get_playback_position() >= 2:
			elevator_ding.play()


func die() -> void:
	if in_elevator:
		elevator.people_in_elevator.remove_at(elevator.people_in_elevator.find(self))
	queue_free()


func handle_collision_outer_walls(ray: RayCast3D) -> void:
	if ray.is_colliding():
		var col := ray.get_collider()
		if col != null:
			if col.is_in_group("outer_walls"):
				direction = -direction
				rotation_degrees.y = 90 if direction >= 0 else -90


func play_conversation(conversation: Array, person_index: int) -> void:
	conversation_player.stream = conversation[person_index]
	conversation_player.play()
