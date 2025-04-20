extends CharacterBody3D

const Conversations := preload("res://Scripts/conversations.gd")

@export var speed := 10.
@export var elevator_strength := 2.
@export var smooth_camera_percent := 0.1
@export var enable_conversations := true
@export var mouse_movement_enabled := true

var wasd_used := false
var mouse_used := false
var people_in_elevator := []
var game_lost := false
var game_won := false

@onready var smooth_camera_controller: Node3D = $SmoothCameraController
@onready var on_fire_stuff: Node3D = $OnFireStuff
@onready var camera_3d: Camera3D = $SmoothCameraController/Camera3D
@onready var rocket_stuff: Node3D = $RocketSuff


func _ready() -> void:
	await get_tree().create_timer(.1).timeout
	on_fire_stuff.hide()
	rocket_stuff.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	smooth_camera_controller.position = position
	if enable_conversations:
		handle_conversations()


func _physics_process(_delta: float) -> void:
	if !game_lost and !game_won:
		var input := Input.get_vector("left", "right", "down", "up")
		var direction := transform.basis * Vector3(input.x, input.y, 0).normalized()
		if direction:
			wasd_used = true
			velocity.x = direction.x * speed
			velocity.y = direction.y * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.y = move_toward(velocity.y, 0, speed)

		if mouse_movement_enabled:
			if wasd_used and Input.get_last_mouse_velocity().y != 0:
				mouse_used = true
			velocity.z = speed * Input.get_last_mouse_velocity().y * 0.001

		if people_in_elevator.size() >= 3:
			velocity.y -= people_in_elevator.size() ** 1.5 - 3

		move_and_slide()

	if Input.is_action_just_pressed("drop") and people_in_elevator.size() >= 1:
		people_in_elevator[0].drop_off(1 if global_position.x < 0 else -1)

	for slide_collision_count in get_slide_collision_count():
		var slide_collision := get_slide_collision(slide_collision_count)
		var collider := slide_collision.get_collider()
		if slide_collision.get_collider() is RigidBody3D and not collider.is_in_group("elevator"):
			slide_collision.get_collider().apply_central_impulse(
				- slide_collision.get_normal() * 30. * elevator_strength
			)
			slide_collision.get_collider().apply_impulse(
				- slide_collision.get_normal() * elevator_strength, slide_collision.get_position()
			)

	if !game_won:
		smooth_camera_controller.position = lerp(
			smooth_camera_controller.position, position, smooth_camera_percent
		)


func _process(_delta: float) -> void:
	var building := get_tree().root.get_child(2).find_child("Building")
	if building:
		if position.z < -7:
			building.hide_front_corridors()
		else:
			building.show_front_corridors()
	if game_won:
		smooth_camera_controller.position = lerp(smooth_camera_controller.position, position, 0.75)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("people"):
		body.enter_elevator()


func handle_conversations() -> void:
	while true:
		await get_tree().create_timer(15).timeout
		if people_in_elevator.size() == 0:
			pass
		elif people_in_elevator.size() == 1:
			var conversation: Array = Conversations.SINGLE_PERSON_CONVERSATIONS.pick_random()
			people_in_elevator[-1].play_conversation(conversation, 0)
		elif people_in_elevator.size() == 2:
			var conversation: Array = Conversations.TWO_PERSON_CONVERSATIONS.pick_random()
			people_in_elevator[-2].play_conversation(conversation, 0)
			people_in_elevator[-1].play_conversation(conversation, 1)
		elif people_in_elevator.size() >= 3:
			var conversation: Array = Conversations.THREE_PERSON_CONVERSATIONS.pick_random()
			people_in_elevator[-3].play_conversation(conversation, 0)
			people_in_elevator[-2].play_conversation(conversation, 1)
			people_in_elevator[-1].play_conversation(conversation, 2)


func lost_game() -> void:
	game_lost = true
	on_fire_stuff.show()


func won_game() -> void:
	game_won = true
	rocket_stuff.show()
	set_collision_mask_value(1, false)
	var elevator_tween := create_tween()
	(
		elevator_tween
		.tween_property(self, "global_position", Vector3(0, 400, 0), 4)
		.set_trans(Tween.TRANS_SINE)
		.set_ease(Tween.EASE_IN_OUT)
	)
	var camera_tween := create_tween()
	(
		camera_tween
		.tween_property(camera_3d, "position", Vector3(0, 12, 30), 4)
		.set_trans(Tween.TRANS_SINE)
		.set_ease(Tween.EASE_IN_OUT)
	)
	await get_tree().create_timer(4).timeout
	rocket_stuff.hide()
	elevator_tween.stop()
	camera_tween.stop()
