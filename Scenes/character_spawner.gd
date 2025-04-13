extends Node3D

@export var character_scene: PackedScene
@export var min_spawn_time: float
@export var max_spawn_time: float

@onready var timer: Timer = $SpawnTimer


func _ready() -> void:
	$CSGMesh3D.hide()

func _on_spawn_timer_timeout() -> void:
	var character = character_scene.instantiate()
	timer.wait_time = randf_range(min_spawn_time, max_spawn_time)
	add_child(character)
