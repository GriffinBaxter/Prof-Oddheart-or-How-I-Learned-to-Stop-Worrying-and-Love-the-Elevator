extends Node3D

@export var character_scene: PackedScene
@export var min_spawn_time: float
@export var max_spawn_time: float

@onready var timer: Timer = $SpawnTimer
@onready var csg_mesh_3d: CSGMesh3D = $CSGMesh3D


func _ready() -> void:
	csg_mesh_3d.hide()


func spawn() -> void:
	var character := character_scene.instantiate()
	timer.wait_time = randf_range(min_spawn_time, max_spawn_time)
	add_child(character)
