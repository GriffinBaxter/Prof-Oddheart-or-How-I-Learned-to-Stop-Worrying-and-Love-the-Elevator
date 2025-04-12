extends Node3D

@onready var timer: Timer = $SpawnTimer

@export var characterScene: PackedScene
@export var minSpawnTime: float
@export var maxSpawnTime: float

func _ready() -> void:
	#timer.wait_time = randf_range(0.5, 1)
	$CSGMesh3D.hide()
	pass

func _process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	var character = characterScene.instantiate()
	timer.wait_time = randf_range(minSpawnTime, maxSpawnTime)
	add_child(character)
