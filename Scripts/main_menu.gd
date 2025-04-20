extends Node3D

const MAIN = preload("res://Scenes/main.tscn")

var elevator: CharacterBody3D

@onready var wasd: TextureRect = $UI/Wasd
@onready var mouse: TextureRect = $UI/Mouse


func _on_go_to_play_body_entered(body: Node3D) -> void:
	if body.is_in_group("elevator"):
		call_deferred("change_scene_to_main")


func change_scene_to_main() -> void:
	get_tree().change_scene_to_packed(MAIN)


func _input(event: InputEvent):
	if (Input.mouse_mode != Input.MOUSE_MODE_CAPTURED) and event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _ready() -> void:
	elevator = get_tree().get_first_node_in_group("elevator")
	blink_tooltips()


func blink_tooltips() -> void:
	while !elevator.wasd_used:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		wasd.hide()
		await get_tree().create_timer(0.5).timeout
		wasd.show()
		await get_tree().create_timer(0.5).timeout
	elevator.mouse_movement_enabled = true
	while !elevator.mouse_used:
		mouse.show()
		await get_tree().create_timer(0.5).timeout
		mouse.hide()
		await get_tree().create_timer(0.5).timeout
	mouse.show()
